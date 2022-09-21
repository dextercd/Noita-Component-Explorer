local string_util = {}

function string_util.ifind(s, pattern, init, plain)
    return string.find(s:lower(), pattern:lower(), init, plain)
end

return string_util
