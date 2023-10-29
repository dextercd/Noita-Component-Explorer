local CE_PARSE_ERROR = "Couldn't parse expression, check logger.txt"

local set_content = ModTextFileSetContent

-- loadstring but returns nil if there's a syntax error
local function loadstring_ish(str)
    local filename = "mods/component-explorer/user_command.lua"
    set_content(filename, str)
    return loadfile(filename)
end

---@param str string String to evaluate
---@return boolean succes
---@return any result
local function eval(str)
    local f = loadstring_ish(str)
    if f == nil then
        return false, CE_PARSE_ERROR
    end

    local success, result = pcall(f)
    return success, result
end

return eval
