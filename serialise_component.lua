local nxml = dofile_once("mods/component-explorer/deps/nxml.lua")
dofile_once("mods/component-explorer/serialise_component_fields.lua")

{% for component in component_documentation %}

function add_{{ component.name }}_fields(component_id, component)
    {% set sections = {
        "Members": component.members,
        "Privates": component.privates,
        "Objects": component.objects,
        "Custom data types": component.custom_data_types,
    } %}
    {% for section_name, fields in sections.items() %}
    {% for field in fields %}
    add_field(component_id, component, "{{ field.type }}", "{{ field.name }}")
    {% endfor %}
    {%- endfor %}
end

{% endfor %}

function add_component_fields(component_id, type_name, component)
{% for component in component_documentation %}
    if type_name == "{{ component.name }}" then
        return add_{{ component.name }}_fields(component_id, component)
    end
{% endfor %}
end

function serialise_component(component_id)
    local type_name = ComponentGetTypeName(component_id)
    local component = nxml.new_element(type_name)

    local enabled = ComponentGetIsEnabled(component_id)
    if not enabled then
        component.attr._enabled = enabled
    end

    add_component_fields(component_id, type_name, component)

    return component
end

