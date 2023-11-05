local ModTextFileGetContent = ModTextFileGetContent

local us = {}

us.directory_path = "user-scripts"

function us.make_path(script_name)
    return "mods/../" .. us.directory_path .. "/" .. script_name:lower()
end

---@param script_name string
---@return any
function us.user_script(script_name)
    -- mods/../ prevents the game from complaining about wrong script paths.
    return loadfile(us.make_path(script_name))()
end

---@param script_name string
---@return boolean
function us.exists(script_name)
    local content = ModTextFileGetContent(script_name)
    return content ~= nil and content ~= ""
end

---@param script_name string
---@return string
function us.user_script_call_string(script_name)
    return 'return user_script("' .. script_name .. '")'
end

---@param script_name string
---@return boolean
function us.is_hidden(script_name)
    return script_name:sub(1, 1) == "_"
end

return us
