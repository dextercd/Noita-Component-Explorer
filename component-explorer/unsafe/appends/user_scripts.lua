local us = dofile_once("mods/component-explorer/user_scripts.lua")

local function read_all(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

function us.user_script(script_name)
    local path = us.make_path(script_name)
    return loadstring(read_all(path), path)()
end
