local string_util = {}

function string_util.ifind(s, pattern, init, plain)
    return string.find(s:lower(), pattern:lower(), init, plain)
end

function string_util.split_iter(str, sep, plain)
    local start = 1

    return function()
        local skip_start, skip_end = string.find(str, sep, start, plain)
        skip_start = skip_start or #str + 1
        skip_end = skip_end or #str + 1

        if start <= skip_start then
            local value = string.sub(str, start, skip_start - 1)
            start = skip_end + 1
            return value
        end
    end
end

function string_util.split(str, sep, plain)
    local result = {}
    for value in string_util.split_iter(str, sep, plain) do
        table.insert(result, value)
    end
    return result
end

return string_util
