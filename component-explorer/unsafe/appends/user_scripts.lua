local us = dofile_once("mods/component-explorer/user_scripts.lua")

local function read_all(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

function us.user_script(script_name)
    local path = us.make_path(script_name)
    local f, err = loadstring(read_all(path), path)
    if not f then
        error(err, 0)
    end

    return f()
end

function us.exists(script_name)
    local path = us.make_path(script_name)
    local handle = io.open(path, "rb")
    if not handle then
        return false
    end

    handle:close()
    return true
end
