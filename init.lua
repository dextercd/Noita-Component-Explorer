if not load_imgui then
    local msg = "ImGui is not installed or enabled, the mod won't work."
    GamePrint(msg)
    print(msg)
    error(msg)
end

local imgui = load_imgui({version="1.0", mod="Modder's Delight"})


function help_marker(desc)
    imgui.TextDisabled("(?)")
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(300)
        imgui.Text(desc)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end


function show_field_int(name, description, component_id)
    local value = ComponentGetValue2(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, value = imgui.InputInt(name, value)
    if changed then
        ComponentSetValue2(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

function show_field_float(name, description, component_id)
    local value = ComponentGetValue2(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, value = imgui.InputFloat(name, value, 1.0)
    if changed then
        ComponentSetValue2(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

local show_field_double = show_field_float

function show_field_bool(name, description, component_id)
    local value = ComponentGetValue2(component_id, name)

    local changed, value = imgui.Checkbox(name, value)
    if changed then
        ComponentSetValue2(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

function show_field_std_string(name, description, component_id)
    local value = ComponentGetValue2(component_id, name)

    imgui.SetNextItemWidth(400)
    local changed, value = imgui.InputText(name, value)
    if changed then
        ComponentSetValue2(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

function show_field_vec2(name, description, component_id)
    local x, y = ComponentGetValue2(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, nx, ny = imgui.InputFloat2(name, x, y)
    if changed then
        ComponentSetValue2(component_id, name, nx, ny)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end


{% for component in component_documentation %}
function show_{{ component.name }}(component_id)
    if not imgui.Begin("{{ component.name }}: " .. component_id) then
        return
    end

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

        {%- set field_type = field.type|replace("::", "_") -%}
        {%- set description = '"' ~ field.description ~ '"' if field.description else "nil" -%}

        {%- if field_type in ["bool", "int", "float", "double", "vec2", "std_string"] %}
        show_field_{{ field_type }}("{{ field.name }}", {{ description }}, component_id)
        {% else %}
        -- show_field_{{ field_type }}("{{ field.name }}", {{ description }}, component_id)
        {% endif -%}

        {% endfor %}
    end

    {%- endif %}
    {%- endfor %}

    imgui.End()
end

{% endfor %}

function OnPlayerSpawned(player_entity)
    player = player_entity
    damage_model = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent")
    controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
end

function OnWorldPreUpdate()

    if damage_model then
        show_DamageModelComponent(damage_model)
    end

    if controls_component then
        show_ControlsComponent(controls_component)
    end

    world_state_entity = GameGetWorldStateEntity()
    world_state = EntityGetFirstComponentIncludingDisabled(world_state_entity, "WorldStateComponent")

    if world_state then
        show_WorldStateComponent(world_state)
    end

end