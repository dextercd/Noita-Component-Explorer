local CE_PARSE_ERROR = "Couldn't parse expression, check logger.txt"

local eval = {}

local set_content = ModTextFileSetContent

--- loadstring but returns nil if there's a syntax error
---@param str string
---@return function?
---@return string?
function eval.loadstring_ish(str)
    local filename = "mods/component-explorer/user_command.lua"
    set_content(filename, str)
    local f, err = loadfile(filename)

    if not f then
        return nil, err or CE_PARSE_ERROR
    end

    return f
end

---@param str string String to evaluate
---@return boolean succes
---@return any result
function eval.eval(str)
    local f, err = eval.loadstring_ish(str)
    if not f then
        return false, err
    end

    return pcall(f)
end

return eval
