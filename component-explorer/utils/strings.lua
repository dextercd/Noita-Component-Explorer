local string_util = {}

function string_util.normalise(s)
    s = string.lower(s)
    s = s:gsub("ä", "a") s = s:gsub("Ä", "a")
    s = s:gsub("ö", "o") s = s:gsub("Ö", "o")
    return s
end

local nm = string_util.normalise

function string_util.ifind(s, pattern, init, plain)
    return string.find(nm(s), nm(pattern), init, plain)
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

function string_util.trim(s)
   return s:gsub("^%s*(.-)%s*$", "%1")
end

function string_util.starts_with(s, start)
    if #s < #start then return false end
    local part = s:sub(1, #start)
    return part == start
end

function string_util.ends_with(s, ending)
    if #s < #ending then return false end
    local part = s:sub(#s - #ending + 1)
    return part == ending
end

function string_util.remove_prefix(s, start)
    if not string_util.starts_with(s, start) then
        return s
    end
    return s:sub(#start + 1)
end

function string_util.remove_suffix(s, ending)
    if not string_util.ends_with(s, ending) then
        return s
    end
    return s:sub(1, #s - #ending)
end

---@param s string
---@return string
function string_util.strip(s)
    return s:match("^%s*(.-)%s*$")
end

return string_util
