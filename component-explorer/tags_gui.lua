local tags_gui = {}

function tags_gui.show(data, tags, add, remove, common_tags)
    common_tags = common_tags or {}

    data.new_tag_input = data.new_tag_input or ""

    imgui.SetNextItemWidth(200)
    local submit
    submit, data.new_tag_input = imgui.InputText(
        "Add tag", data.new_tag_input,
        imgui.InputTextFlags.EnterReturnsTrue
    )
    if submit then
        add(data.new_tag_input)
        data.new_tag_input = ""
    end

    local tag_set = {}
    for _, tag in ipairs(tags) do
        tag_set[tag] = true
    end

    if #common_tags > 0 then
        imgui.SameLine()
        if imgui.Button("Common..") then
            imgui.OpenPopup("common_tags_popup")
        end

        if imgui.BeginPopup("common_tags_popup") then
            for _, tag in ipairs(common_tags) do
                if imgui.MenuItem(tag, "", tag_set[tag] ~= nil) then
                    if tag_set[tag] then
                        remove(tag)
                    else
                        add(tag)
                    end
                end
            end
            imgui.EndPopup()
        end
    end

    local table_flags = imgui.TableFlags.Resizable
    if imgui.BeginTable("tags", 2, table_flags) then

        imgui.TableSetupColumn("Tag")
        imgui.TableSetupColumn("Remove", imgui.TableColumnFlags.WidthFixed)
        imgui.TableHeadersRow()

        for _, tag in ipairs(tags) do
            imgui.PushID(tag)

            imgui.TableNextColumn()
            imgui.Text(tag)

            imgui.TableNextColumn()
            if imgui.SmallButton("-") then
                remove(tag)
            end

            imgui.PopID()
        end

        imgui.EndTable()
    end
end

return tags_gui
