if not load_imgui then
    local msg = "ImGui is not installed or enabled, the mod won't work."
    GamePrint(msg)
    print(msg)
    error(msg)
end

local imgui = load_imgui({version="0.0.1", mod="Modder's Delight"})

{% for component in component_documentation %}
function show_{{ component.name }}(component_id)
end
{% endfor %}
