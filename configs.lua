dofile_once("mods/component-explorer/component_fields.lua")

{% set supported_fields = [
    "bool",
    "float",
    "int", "unsignedint", "int32", "uint32",
    "types_vector2",
    "ValueRange", "ValueRangeInt",
    "string",
    "EntityID",
] -%}

{% set used_configs = [
    "ConfigDamageCritical",
    "ConfigDamagesByType",
    "ConfigDrugFx",
    "ConfigExplosion",
    "ConfigGun",
    "ConfigGunActionInfo",
    "ConfigLaser",
] -%}

{% for config in configs %}
{% if config.name in used_configs %}
function show_{{ config.name }}_fields(field_name, description, component_id)
    {%- set sections = {
        "Members": config.members,
        "Privates": config.privates,
        "Custom data types": config.custom_data_types,
    } %}

    local function get(component_id, name)
        return ComponentObjectGetValue2(component_id, field_name, name)
    end

    local function set(component_id, name, ...)
        return ComponentObjectSetValue2(component_id, field_name, name, ...)
    end

    {%- for section_name, fields in sections.items() -%}
    {%- if fields %}

    {% if config.privates or config.custom_data_types %}
    if imgui.TreeNode("{{ section_name }}") then
    {% endif %}

        {% for field in fields -%}

        {%- set field_type = field.type|replace("::", "_")|replace("std_","")|replace("<", "_")|replace(">", "") -%}
        {%- set description = '"' ~ field.description ~ '"' if field.description else "nil" -%}

        {% if field.type is regex('^u?(nsigned)?int[0-9]*$') %}
        show_field_int("{{ field.name }}", {{ description }}, component_id, get, set)
        {% elif field_type in supported_fields %}
        show_field_{{ field_type }}("{{ field.name }}", {{ description }}, component_id, get, set)
        {% else %}
        -- show_field_{{ field_type }}("{{ field.name }}", {{ description }}, component_id)
        {% endif -%}

        {% endfor %}

    {% if config.privates or config.custom_data_types %}
        imgui.TreePop()
    end
    {% endif %}

    {% endif -%}
    {% endfor -%}
end

{% endif %}
{% endfor %}
