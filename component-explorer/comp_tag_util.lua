local comp_tag_util = {}

-- From https://noita.wiki.gg/wiki/Modding:_Special_tags#Component_tags
comp_tag_util.special_tags = {
    "enabled_in_hand",
    "enabled_in_world",
    "enabled_in_inventory",
    "shop_cost",
    "fire",
}

function comp_tag_util.special_tags_xml_value(component_id)
    local str = ""
    for _, tag in ipairs(comp_tag_util.special_tags) do
        if ComponentHasTag(component_id, tag) then
            if str ~= "" then str = str .. "," end
            str = str .. tag
        end
    end

    return str
end

return comp_tag_util
