local wiki = {}

function wiki.format_template(template_name, values, alignment)
    local param_strings = {""}
    for _, item in ipairs(values) do
        local key, value = unpack(item)
        local to_align = math.max(0, alignment - string.len(key))
        table.insert(param_strings, key .. string.rep(" ", to_align) .. " = " .. tostring(value))
    end

    local param_string = table.concat(param_strings, "\n| ")
    return "{{" .. template_name .. param_string .. "\n}}"
end

return wiki
