local nxml = dofile_once("mods/component-explorer/deps/nxml.lua")
local comp_tag_util = dofile_once("mods/component-explorer/utils/component_tags.lua")
dofile_once("mods/component-explorer/serialise_component_fields.lua")

{% for component in component_documentation %}

function add_{{ component.name }}_fields(component_id, component, include_privates)
    {% set sections = {
        "Members": component.members,
        "Objects": component.objects,
        "Custom data types": component.custom_data_types,
    } %}

    {%- for section_name, fields in sections.items() %}
    {% for field in fields %}
    add_field(component_id, component, "{{ field.type }}", "{{ field.name }}")
    {% endfor %}
    {%- endfor %}

    {%- if component.privates %}

    if include_privates then
        {% for field in component.privates %}
        add_field(component_id, component, "{{ field.type }}", "{{ field.name }}")
        {% endfor %}
    end
    {% endif %}
end

{% endfor %}

function add_component_fields(component_id, type_name, component, include_privates)
{% for component in component_documentation %}
    if type_name == "{{ component.name }}" then
        return add_{{ component.name }}_fields(component_id, component, include_privates)
    end
{% endfor %}
end

function serialise_component(component_id, include_privates)
    local type_name = ComponentGetTypeName(component_id)
    local component = nxml.new_element(type_name)

    local enabled = ComponentGetIsEnabled(component_id)
    if not enabled then
        component.attr._enabled = enabled
    end

    add_component_fields(component_id, type_name, component, include_privates)

    local tags = ComponentGetTags(component_id)
    if tags and tags ~= "" then
        component.attr._tags = tags
    end

    return component
end

