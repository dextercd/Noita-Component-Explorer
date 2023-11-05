local nxml = dofile_once("mods/component-explorer/deps/nxml.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

local xml_serialise = {}

xml_serialise.use_tabs = ce_settings.get("xml_indent_char") == "tab"
xml_serialise.space_count = ce_settings.get("xml_space_count")
xml_serialise.include_privates = ce_settings.get("xml_include_privates")

function xml_serialise.button()
    _, xml_serialise.use_tabs = imgui.Checkbox("Use tabs", xml_serialise.use_tabs)
    if not xml_serialise.use_tabs then
        imgui.SameLine()
        _, xml_serialise.space_count = imgui.SliderInt("Space Count", xml_serialise.space_count, 1, 8)
    end

    _, xml_serialise.include_privates = imgui.Checkbox("Include privates", xml_serialise.include_privates)

    return imgui.Button("Copy XML (Beta)")
end

function xml_serialise.indentation()
    if xml_serialise.use_tabs then
        return "\t"
    end

    return string.rep(" ", xml_serialise.space_count)
end

function xml_serialise.tostring(element)
    return nxml.tostring(element, false, xml_serialise.indentation())
end

return xml_serialise
