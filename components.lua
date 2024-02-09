dofile_once("mods/component-explorer/serialise_component.lua")
dofile_once("mods/component-explorer/component_fields.lua")
dofile_once("mods/component-explorer/configs.lua")
local matinv_field = dofile_once("mods/component-explorer/matinv_field.lua")
local help = dofile_once("mods/component-explorer/ui/help.lua")

component_types = {
    {% for component in component_documentation %}
    "{{ component.name }}",
    {% endfor %}
}


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

{% endfor %}

component_type_functions = {
{% for component in component_documentation %}
    {{ component.name }} = {
        show_fields = show_{{ component.name }}_fields,
    },
{% endfor %}
}
