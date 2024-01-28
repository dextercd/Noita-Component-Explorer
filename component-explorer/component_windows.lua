dofile_once("mods/component-explorer/components.lua")

---@module 'component-explorer.ui.help'
local help = dofile_once("mods/component-explorer/ui/help.lua")

---@module 'component-explorer.tags_gui'
local tags_gui = dofile_once("mods/component-explorer/tags_gui.lua")

---@module 'component-explorer.xml_serialise'
local xml_serialise = dofile_once("mods/component-explorer/xml_serialise.lua")

---@module 'component-explorer.component_tags'
local comp_tag_util = dofile_once("mods/component-explorer/utils/component_tags.lua")

---@module 'component-explorer.ui.im'
local im = dofile_once("mods/component-explorer/ui/im.lua")

local components_watching = {}
local components_to_remove = {}

function unwatch_component(component_id)
    components_watching[component_id] = nil
end

function watch_component(entity_id, component_id, open_data)
    local type = ComponentGetTypeName(component_id)

    local window_id = "###comp_" .. entity_id .. "_" .. component_id

    components_watching[component_id] = {
        entity_id,
        im.Window(window_id, true, imgui.WindowFlags.NoSavedSettings, open_data),
        --[[ data --]] {
            tag_data = {},
            show_fields_fn = component_type_functions[type].show_fields,
            type = type,
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
            local open_data = im.GetOpenData()
            watch_component(entity_id, component_id, open_data)
        end
    end
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

---@param entity_id integer
---@param component_id integer
---@param window Window
---@param data any
local function show_component_window(entity_id, component_id, window, data)
    local should_show = im.Begin(window, data.type .. ": " .. component_id)

    if not window.open then
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

    data.show_fields_fn(entity_id, component_id, data)

    im.End(window)
end

function show_component_windows()
    local known_components = {}
    for component, entry in pairs(components_watching) do
        local entity, window, data = unpack(entry)

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
            show_component_window(entity, component, window, data)
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
