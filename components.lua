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
    "int64", "uint64",
    "AudioSourceHandle",
    "types_vector2", "vec2", "ivec2",
    "types_aabb",
    "types_iaabb",
    "types_xform",
    "ValueRange", "ValueRangeInt",
    "string", "USTRING",
    "EntityID",
    "types_fcolor",
    "vector_entityid",
    "VISITED_VEC",
    "EntityTypeID",
]
%}

{% set simple_vectors = [
    "VEC_OF_MATERIALS",
    "vector_int32",
    "vector_float",
    "vector_string",
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

        {%- set description = '"' ~ field.description ~ '"' if field.description else "nil" -%}

        {% if section_name == "Objects" %}
        local object_open = imgui.TreeNode("{{ field.name }} {{ field.type }}")
        {% if field.description %}
        imgui.SameLine()
        help.marker("{{ field.description }}")
        {% endif %}
        if object_open then
            show_{{ field.type }}_fields("{{ field.name }}", {{ description }}, component_id)
            imgui.TreePop()
        end
        {% elif field.type == "uint32" and "color" in field.name %}
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
        {% elif field.type in supported_fields %}
        show_field_{{ field.type }}("{{ field.name }}", {{ description }}, component_id)
        {% elif field.type is regex('^(LensValue_)?u?int[0-9]*$') %}
        show_field_int("{{ field.name }}", {{ description }}, component_id)
        {% elif field.type == "MATERIAL_VEC_DOUBLES" %}
        matinv_field.show_field_MATERIAL_VEC_DOUBLES("{{ field.name }}", {{ description }}, entity_id, component_id)
        {% elif field.type.endswith("_Enum") and "ComponentState" not in field.type %}
        show_field_enum("{{ field.name }}", {{ description }}, component_id, {{ field.type.rpartition("_Enum")[0].lower() }})
        {% elif field.type in simple_vectors %}
        show_field_ro_list("{{ field.name }}", {{ description }}, component_id)
        {% else %}
        -- show_field_{{ field.type }}("{{ field.name }}", {{ description }}, component_id)
        show_field_unsupported("{{ field.name }}", {{ description }}, component_id, "{{ field.raw_type }}")
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
