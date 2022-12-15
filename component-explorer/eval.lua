CE_PARSE_ERROR = "Couldn't parse expression, check logger.txt"

local set_content = ModTextFileSetContent
local nr = 1

-- loadstring but returns nil if there's a syntax error
local function loadstring_ish(str)
    local filename = "mods/component-explorer/command" .. nr .. ".lua"
    nr = nr + 1

    set_content(filename, str)

    return loadfile(filename)
end

function eval(str)
    local f = loadstring_ish(str)
    if f == nil then
        return false, CE_PARSE_ERROR
    end

    local status, result = pcall(f)
    return status, result
end
