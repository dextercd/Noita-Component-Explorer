dofile_once("mods/component-explorer/component_fields.lua")

if not load_imgui then
    local msg = "ImGui is not installed or enabled, the mod won't work."
    GamePrint(msg)
    print(msg)
    error(msg)
end

imgui = load_imgui({version="1.0", mod="Component Explorer"})


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
    if not imgui.Begin("{{ component.name }}: " .. component_id) then
        return
    end

    toggle_component_button(entity_id, component_id)

    show_{{ component.name }}_fields(component_id)

    imgui.End()
end

{% endfor %}

local components_watching = {}

function OnPlayerSpawned(player_entity)
    player = player_entity
    damage_model = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent")
    controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")

    if damage_model then
        table.insert(components_watching, {player, damage_model, show_DamageModelComponent_window})
    end

    if controls_component then
        table.insert(components_watching, {player, controls_component, show_ControlsComponent_window})
    end

    for i, v in ipairs(EntityGetAllChildren(player) or {}) do
        if EntityGetName(v) == "cape" then
            cape = v
        end
    end

    if cape then
        verlet = EntityGetFirstComponentIncludingDisabled(cape, "VerletPhysicsComponent")
        table.insert(components_watching, {cape, verlet, show_VerletPhysicsComponent_window})
    end
end


function OnWorldPreUpdate()

    local known_components = {}

    for _, entry in ipairs(components_watching) do
        local entity, component, show = unpack(entry)

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
        end
    end


    world_state_entity = GameGetWorldStateEntity()
    world_state = EntityGetFirstComponentIncludingDisabled(world_state_entity, "WorldStateComponent")

    if world_state then
        show_WorldStateComponent_window(world_state_entity, world_state)
    end


end
