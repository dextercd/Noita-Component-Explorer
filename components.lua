dofile_once("mods/component-explorer/serialise_component.lua")
dofile_once("mods/component-explorer/component_fields.lua")
local xml_serialise = dofile_once("mods/component-explorer/xml_serialise.lua")
local comp_tag_util = dofile_once("mods/component-explorer/comp_tag_util.lua")

component_types = {
    {% for component in component_documentation %}
    "{{ component.name }}",
    {% endfor %}
}

local components_watching = {}
local components_to_remove = {}

function unwatch_component(component_id)
    components_watching[component_id] = nil
end

function watch_component(entity_id, component_id)
    local type = ComponentGetTypeName(component_id)
    components_watching[component_id] = {entity_id, component_type_functions[type].show_window}
end

function toggle_watch_component(entity_id, component_id)
    if components_watching[component_id] then
        unwatch_component(component_id)
    else
        watch_component(entity_id, component_id)
    end
end

function open_component_small_button(entity_id, component_id)
    if components_watching[component_id] then
        if imgui.SmallButton("Close###open_component_small_button" .. component_id) then
            unwatch_component(component_id)
        end
    else
        if imgui.SmallButton("Open###open_component_small_button" .. component_id) then
            watch_component(entity_id, component_id)
        end
    end
end

function show_component_windows()
    local known_components = {}
    for component, entry in pairs(components_watching) do
        local entity, show = unpack(entry)

        if known_components[entity] == nil then
            if not EntityGetIsAlive(entity) then
                known_components[entity] = false
            else
                known_components[entity] = {}
                local entity_components = known_components[entity]
                local all_comps = EntityGetAllComponents(entity)
                for _, comp in ipairs(all_comps) do
                    entity_components[comp] = true
                end
            end
        end

        if known_components[entity] and known_components[entity][component] then
            show(entity, component)
        else
            unwatch_component(component)
        end
    end

    for _, pair in ipairs(components_to_remove) do
        local entity_id, component_id = unpack(pair)
        EntityRemoveComponent(entity_id, component_id)
    end
    components_to_remove = {}
end

function component_attributes(entity_id, component_id)
    if xml_serialise.button() then
        local component_xml = serialise_component(component_id, xml_serialise.include_privates)
        imgui.SetClipboardText(xml_serialise.tostring(component_xml))
    end

    imgui.Separator()

    local enabled = ComponentGetIsEnabled(component_id)
    imgui.Text("Enabled: " .. tostring(enabled))
    imgui.SameLine()
    imgui.SetCursorPosX(imgui.GetFontSize() * 8)
    if imgui.Button("Toggle") then
        EntitySetComponentIsEnabled(entity_id, component_id, not enabled)
    end

    imgui.PushStyleColor(imgui.Col.Button, 1, 0.4, 0.4)
    imgui.PushStyleColor(imgui.Col.ButtonHovered, 1, 0.6, 0.6)
    imgui.PushStyleColor(imgui.Col.ButtonActive, 0.8, 0.4, 0.4)
    if imgui.Button("Remove") then
        table.insert(components_to_remove, {entity_id, component_id})
    end
    imgui.PopStyleColor(3)
end

function component_tags(entity_id, component_id)
    for i, tag in ipairs(comp_tag_util.special_tags) do
        local has_tag = ComponentHasTag(component_id, tag)
        local changed, new_val = imgui.Checkbox(tag, has_tag)
        if changed then
            if new_val then
                ComponentAddTag(component_id, tag)
            else
                ComponentRemoveTag(component_id, tag)
            end
        end
    end
end

{% set supported_fields = [
    "bool", "LensValue_bool",
    "float", "double",
    "int", "unsignedint", "int16", "uint16", "int32", "uint32", "int64", "uint64",
    "vec2", "ivec2",
    "std_string",
    "EntityID",
]
%}

{% for component in component_documentation %}
function show_{{ component.name }}_fields(component_id)
    {%- set sections = {
        "Members": component.members,
        "Privates": component.privates,
        "Objects": component.objects,
        "Custom data types": component.custom_data_types,
    } -%}

    {%- for section_name, fields in sections.items() -%}
    {%- if fields %}

    if imgui.CollapsingHeader("{{ section_name }}") then
        {% for field in fields -%}

        {%- set field_type = field.type|replace("::", "_")|replace("<", "_")|replace(">", "") -%}
        {%- set description = '"' ~ field.description ~ '"' if field.description else "nil" -%}

        {% if field_type == "uint32" and "color" in field.name %}
        show_field_abgr("{{ field.name }}", {{ description }}, component_id)
        {% elif field_type in supported_fields %}
        show_field_{{ field_type }}("{{ field.name }}", {{ description }}, component_id)
        {% elif field.type == "RAGDOLL_FX::Enum" %}
        show_field_enum("{{ field.name }}", {{ description }}, component_id, ragdoll_fx)
        {% elif field.type == "PROJECTILE_TYPE::Enum" %}
        show_field_enum("{{ field.name }}", {{ description }}, component_id, projectile_type)
        {% elif field_infos.get(component.name, {}).get(field.name, {}).handler %}
            {% set field_info = field_infos[component.name][field.name] %}
            {% set handler = field_info.handler %}
            {% if handler.startswith("#") %}
                {% if handler == "#done" %}
                {% elif handler == "#spread_aabb" %}
        show_field_spread_aabb("{{ field.name.removesuffix("_min_x") }}", {{ description }}, component_id)
                {% elif handler == "#enum" %}
        show_field_enum("{{ field.name }}", {{ description }}, component_id, {{ field_info.enum }})
                {% else %}
                    {{ "Unhandled case"/0 }}
                {% endif %}
            {% else %}
        {{ handler }}("{{ field.name }}", {{ description }}, component_id)
            {% endif %}
        {% else %}
        -- show_field_{{ field_type }}("{{ field.name }}", {{ description }}, component_id)
        {% endif -%}

        {% endfor %}
    end

    {% endif %}
    {%- endfor %}
end

function show_{{ component.name }}_window(entity_id, component_id)
    imgui.SetNextWindowSize(600, 400, imgui.Cond.Once)
    local should_show, open = imgui.Begin("{{ component.name }}: " .. component_id, true)

    if not open then
        unwatch_component(component_id)
    end

    if not should_show then
        return
    end

    if imgui.CollapsingHeader("Attributes") then
        component_attributes(entity_id, component_id)
    end

    if imgui.CollapsingHeader("Tags") then
        component_tags(entity_id, component_id)
    end

    show_{{ component.name }}_fields(component_id)

    imgui.End()
end

{% endfor %}

component_type_functions = {
{% for component in component_documentation %}
    {{ component.name }} = {
        show_fields = show_{{ component.name }}_fields,
        show_window = show_{{ component.name }}_window,
    },
{% endfor %}
}
