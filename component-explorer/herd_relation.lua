---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.help'
local help = dofile_once("mods/component-explorer/help.lua")

---@module 'component-explorer.link_ui'
local link_ui = dofile_once("mods/component-explorer/link_ui.lua")

---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

local herd_relation = {}

herd_relation.open = false

local UNUSED_HERDS = {
    ["-1"] = true,
    ["crawler"] = true,
    ["ghoul"] = true,
    ["electricity"] = true,
    ["curse"] = true,
}

local attacker_search = ""
local target_search = ""
local exclude_unused = true

function herd_relation.show()
    local should_show
    should_show, herd_relation.open = imgui.Begin("Herd Relation", herd_relation.open)

    if not should_show then
        return
    end

    link_ui.button("See the wiki for more info", "https://noita.wiki.gg/wiki/Factions")

    local _
    imgui.SetNextItemWidth(200)
    _, attacker_search = imgui.InputText("Attacker", attacker_search)

    imgui.SameLine(0, 40)
    imgui.SetNextItemWidth(200)
    _, target_search = imgui.InputText("Target", target_search)

    _, exclude_unused = imgui.Checkbox("Excluded unused herds", exclude_unused)

    imgui.SameLine()
    help.marker(
        "Certain herds are unused in the base game. You can hide columns by right clicking the table.\n\n" ..
        "Higher relation means less chance to attack.\n\n" ..
        "Rows are the attacker and columns are the herd that may be attacked depending on the relation.\n\n" ..
        "Herds that have a different opposite relation use orange text.")

    local available_herds = {}
    for herd_id=0,1000 do
        local herd_name = HerdIdToString(herd_id)
        if herd_name == "" then
            break
        end

        if not exclude_unused or not UNUSED_HERDS[herd_name] then
            table.insert(available_herds, {herd_id, herd_name})
        end
    end

    local filtered_targets = {}

    for _, available_herd in ipairs(available_herds) do
        local herd_id, herd_name = unpack(available_herd)
        if string_util.ifind(herd_name, target_search, 1, false) then
            table.insert(filtered_targets, {herd_id, herd_name})
        end
    end

    imgui.Separator()

    local table_flags = bit.bor(
        imgui.TableFlags.Hideable,
        imgui.TableFlags.ContextMenuInBody,
        imgui.TableFlags.Borders
    )

    if imgui.BeginTable("herdrelation", #filtered_targets + 1, table_flags) then
        imgui.TableSetupColumn("Faction", imgui.TableColumnFlags.NoHide)
        for _, filtered_target in ipairs(filtered_targets) do
            local _, name = unpack(filtered_target)
            imgui.TableSetupColumn(name)
        end
        imgui.TableHeadersRow()

        for _, available_herd in ipairs(available_herds) do
            local attacker_id, attacker_name = unpack(available_herd)

            if string_util.ifind(attacker_name, attacker_search, 1, false) then
                imgui.TableNextColumn()
                imgui.Text(attacker_name)

                for _, target in ipairs(filtered_targets) do
                    local target_id, target_name = unpack(target)
                    local relation = GetHerdRelation(attacker_id, target_id)
                    local reverse_relation = GetHerdRelation(target_id, attacker_id)
                    imgui.TableNextColumn()

                    if relation ~= reverse_relation then imgui.PushStyleColor(imgui.Col.Text, 1, 0.56, 0.22) end
                    imgui.Text(tostring(relation))
                    if relation ~= reverse_relation then imgui.PopStyleColor() end

                    if relation < 100 then
                        local intensity = math.max(0, (100 - relation) / 200)
                        imgui.TableSetBgColor(imgui.TableBgTarget.CellBg, 1, 0, 0, 0.2 + intensity)
                    end

                    if imgui.IsItemHovered() then
                        imgui.BeginTooltip()
                        imgui.Text("Attacker: " .. attacker_name)
                        imgui.Text("Target: " .. target_name)
                        imgui.Text("Relation: " .. relation)
                        imgui.Text("Opposite relation: " .. reverse_relation)
                        imgui.EndTooltip()
                    end
                end
            end
        end

        imgui.EndTable()
    end

    imgui.End()
end

return herd_relation
