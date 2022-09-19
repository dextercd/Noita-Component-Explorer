dofile_once("mods/component-explorer/component_fields.lua")

local components_watching = {}

function unwatch_component(component_id)
    components_watching[component_id] = nil
end

function watch_component(entity_id, component_id)
    local type = ComponentGetTypeName(component_id)
    components_watching[component_id] = {entity_id, component_type_functions[type].show_window}
end

function open_component_small_button(entity_id, component_id)
    if components_watching[component_id] ~= nil then
        return
    end

    if imgui.SmallButton("Open") then
        watch_component(entity_id, component_id)
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
end

function toggle_component_button(entity_id, component_id)
    local enabled = ComponentGetIsEnabled(component_id)
    imgui.Text("Enabled: " .. tostring(enabled))
    imgui.SameLine()
    imgui.SetCursorPosX(imgui.GetFontSize() * 8)
    if imgui.Button("Toggle") then
        EntitySetComponentIsEnabled(entity_id, component_id, not enabled)
    end
end

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
        {% elif field_type in ["bool", "int", "float", "double", "vec2",
            "ivec2", "std_string", "unsignedint", "int16", "uint16", "int32",
            "uint32", "int64", "uint64"] %}
        show_field_{{ field_type }}("{{ field.name }}", {{ description }}, component_id)
        {% else %}
        -- show_field_{{ field_type }}("{{ field.name }}", {{ description }}, component_id)
        {% endif -%}

        {% endfor %}
    end

    {% endif %}
    {%- endfor %}
end

function show_{{ component.name }}_window(entity_id, component_id)
    local should_show, open = imgui.Begin("{{ component.name }}: " .. component_id, true)

    if not open then
        unwatch_component(component_id)
    end

    if not should_show then
        return
    end

    toggle_component_button(entity_id, component_id)

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
