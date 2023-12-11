dofile_once("mods/component-explorer/serialise_component.lua")
dofile_once("mods/component-explorer/component_fields.lua")
dofile_once("mods/component-explorer/configs.lua")
local matinv_field = dofile_once("mods/component-explorer/matinv_field.lua")

local xml_serialise = dofile_once("mods/component-explorer/xml_serialise.lua")
local comp_tag_util = dofile_once("mods/component-explorer/utils/component_tags.lua")
local tags_gui = dofile_once("mods/component-explorer/tags_gui.lua")
local stable_id = dofile_once("mods/component-explorer/stable_id.lua")
---@module 'component-explorer.help'
local help = dofile_once("mods/component-explorer/help.lua")

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
    components_watching[component_id] = {
        entity_id,
        component_type_functions[type].show_window,
        --[[ data --]] {
            tag_data = {}
        },
    }
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
        local entity, show, data = unpack(entry)

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
            show(entity, component, data)
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
    local enabled_changed
    enabled_changed, enabled = imgui.Checkbox("Enabled", enabled)
    if enabled_changed then
        EntitySetComponentIsEnabled(entity_id, component_id, enabled)
    end

    imgui.SameLine()

    imgui.PushStyleColor(imgui.Col.Button, 1, 0.4, 0.4)
    imgui.PushStyleColor(imgui.Col.ButtonHovered, 1, 0.6, 0.6)
    imgui.PushStyleColor(imgui.Col.ButtonActive, 0.8, 0.4, 0.4)
    if imgui.Button("Remove") then
        table.insert(components_to_remove, {entity_id, component_id})
    end
    imgui.PopStyleColor(3)

    imgui.Text("Entity:")
    imgui.SameLine()
    open_entity_small_button(entity_id)
end

local function new_component_tags(component_id, data)
    local tag_string = ComponentGetTags(component_id)
    local tags = {}
    for tag in string.gmatch(tag_string, "[^,]+") do
        table.insert(tags, tag)
    end

    local function add_tag(t) ComponentAddTag(component_id, t) end
    local function remove_tag(t) ComponentRemoveTag(component_id, t) end
    tags_gui.show(data.tag_data, tags, add_tag, remove_tag, comp_tag_util.special_tags)

    if imgui.Button("Copy tag string") then
        imgui.SetClipboardText(tag_string)
    end
end

local function limited_component_tags(component_id)
    imgui.Text("Note: Only showing some tags.")
    imgui.SameLine()
    help.marker("In this version of Noita there's no way to get all tags on a component, so only some special tags are listed.")

    for _, tag in ipairs(comp_tag_util.special_tags) do
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

local function component_tags(component_id, data)
    if ComponentGetTags then
        new_component_tags(component_id, data)
    else
        limited_component_tags(component_id)
    end
end

{% set supported_fields = [
    "bool", "LensValue_bool",
    "float", "double", "LensValue_float",
    "int", "unsignedint", "int16", "uint16", "int32", "uint32", "uint32_t", "int64", "uint64", "LensValue_int",
    "AudioSourceHandle",
    "types_vector2", "vec2", "ivec2",
    "types_aabb",
    "types_xform",
    "ValueRange", "ValueRangeInt",
    "std_string", "USTRING",
    "EntityID",
    "types_fcolor",
    "VECTOR_ENTITYID", "VEC_ENTITY", "ENTITY_VEC",
    "VISITED_VEC",
    "EntityTypeID",
]
%}

{% set simple_vectors = [
    "VECTOR_FLOAT",
    "VEC_OF_MATERIALS",
    "VECTOR_INT32",
    "VECTOR_INT",
    "std_vector_int",
    "std_vector_float",
    "VECTOR_STRING",
    "VECTOR_STR",
    "FloatArrayInline",
    "Vec2ArrayInline",
]%}
{# ArrayInline can be written to #}
{# changed_materials on WorldStateComponent can use a better handler #}

{% for component in component_documentation %}
function show_{{ component.name }}_fields(entity_id, component_id, data)
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

        {% if section_name == "Objects" %}
        local object_open = imgui.TreeNode("{{ field.name }} {{ field.type }}")
        {% if field.description %}
        imgui.SameLine()
        help.marker("{{ field.description }}")
        {% endif %}
        if object_open then
            show_{{ field_type }}_fields("{{ field.name }}", {{ description }}, component_id)
            imgui.TreePop()
        end
        {% elif field_type == "uint32" and "color" in field.name %}
        show_field_abgr("{{ field.name }}", {{ description }}, component_id)
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
        {% elif field_type in supported_fields %}
        show_field_{{ field_type }}("{{ field.name }}", {{ description }}, component_id)
        {% elif field_type == "MATERIAL_VEC_DOUBLES" %}
        matinv_field.show_field_MATERIAL_VEC_DOUBLES("{{ field.name }}", {{ description }}, entity_id, component_id)
        {% elif field.type.endswith("::Enum") and "ComponentState" not in field.type %}
        show_field_enum("{{ field.name }}", {{ description }}, component_id, {{ field.type.rpartition("::Enum")[0].lower() }})
        {% elif field_type in simple_vectors %}
        show_field_ro_list("{{ field.name }}", {{ description }}, component_id)
        {% else %}
        -- show_field_{{ field_type }}("{{ field.name }}", {{ description }}, component_id)
        show_field_unsupported("{{ field.name }}", {{ description }}, component_id, "{{ field.type }}")
        {% endif -%}

        {% endfor %}
    end

    {% endif %}
    {%- endfor %}
end

function show_{{ component.name }}_window(entity_id, component_id, data)
    imgui.SetNextWindowSize(600, 400, imgui.Cond.FirstUseEver)

    local entity_sid = stable_id.get("entity", entity_id, EntityGetName(entity_id))
    local component_sid = stable_id.get(entity_sid .. "$component", component_id, "{{ component.name }}")

    local should_show, open = imgui.Begin("{{ component.name }}: " .. component_id .. "###" .. component_sid, true)

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
        component_tags(component_id, data)
    end

    show_{{ component.name }}_fields(entity_id, component_id, data)

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
