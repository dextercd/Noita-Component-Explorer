local ffi = require("ffi")
local win32 = dofile_once("mods/component-explorer/utils/win32.lua")

local us = {}

us.directory_path = "user-scripts"

win32.create_directory(us.directory_path)

function us.user_script(script_name)
    -- mods/../ prevents the game from complaining about wrong script paths.
    return loadfile("mods/../" .. us.directory_path .. "/" .. script_name)()
end

local SCRIPTS_TREE_FETCH_EVERY = 60 * 3

local cached_scripts_tree = {}
local scripts_tree_last_time_fetched = nil

local function fetch_scripts_tree()
    return win32.list_dir_contents(us.directory_path .. "\\*.lua")
end

function us.get_scripts_tree()
    local frame_num = GameGetFrameNum()
    if
        scripts_tree_last_time_fetched and
        frame_num - scripts_tree_last_time_fetched < SCRIPTS_TREE_FETCH_EVERY
    then
        return cached_scripts_tree
    end

    scripts_tree_last_time_fetched = frame_num
    cached_scripts_tree = fetch_scripts_tree()

    return cached_scripts_tree
end

function us.is_hidden(filename)
    return #filename >= 1 and string.sub(filename, 1, 1) == "_"
end

return us
