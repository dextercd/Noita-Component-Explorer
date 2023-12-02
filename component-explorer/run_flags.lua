---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

local run_flags = {}

run_flags.open = false

local input = ""
local search = ""

function run_flags.show()
    local should_show
    should_show, run_flags.open = imgui.Begin("Run Flags", run_flags.open)

    if not should_show then
        return
    end

    local add_flag
    add_flag, input = imgui.InputText("Run flag", input, imgui.InputTextFlags.EnterReturnsTrue)

    imgui.SameLine()
    if imgui.Button("Add") then
        add_flag = true
    end

    if add_flag then
        GameAddFlagRun(input)
        input = ""
    end

    imgui.Separator()

    local world_state_entity = GameGetWorldStateEntity()
    local world_state = EntityGetFirstComponent(world_state_entity, "WorldStateComponent")

    if not world_state then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_fail))
        imgui.Text("No WorldStateComponent found.")
        imgui.PopStyleColor()
    else
        _, search = imgui.InputText("Search", search)

        local flags = ComponentGetValue2(world_state, "flags")
        local filtered_flags = {}
        for _, flag in ipairs(flags) do
            if string_util.ifind(flag, search, 1, false) then
                table.insert(filtered_flags, flag)
            end
        end
        table.sort(filtered_flags)

        local table_flags = imgui.TableFlags.Resizable
        if imgui.TableGetSortSpecs then
            table_flags = bit.bor(table_flags, imgui.TableFlags.Sortable)
        end

        if imgui.BeginTable("run_flags", 2, table_flags) then
            imgui.TableSetupColumn("Flag")
            imgui.TableSetupColumn("Actions", imgui.TableColumnFlags.NoSort)
            imgui.TableHeadersRow()

            if imgui.TableGetSortSpecs then
                local _, sortspec = imgui.TableGetSortSpecs()
                if sortspec then
                    local columnspec = sortspec.Specs[1]
                    table.sort(filtered_flags,
                        columnspec.SortDirection == imgui.SortDirection.Ascending
                            and function(a, b) return a < b end
                            or function(a, b) return  a > b end)
                end
            else
                table.sort(filtered_flags)
            end

            for _, flag in ipairs(filtered_flags) do
                imgui.PushID(flag)
                imgui.TableNextColumn()
                imgui.Text(flag)

                imgui.TableNextColumn()
                if imgui.SmallButton("Remove") then
                    GameRemoveFlagRun(flag)
                end
                imgui.PopID()
            end

            imgui.EndTable()
        end
    end

    imgui.End()
end

return run_flags
