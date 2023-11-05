local win32 = dofile_once("mods/component-explorer/unsafe/win32.lua")
local us = dofile_once("mods/component-explorer/user_scripts.lua")

local us_unsafe = {}

win32.create_directory(us.directory_path)

local SCRIPTS_TREE_FETCH_EVERY = 60 * 3

local cached_scripts_tree = {}
local scripts_tree_last_time_fetched = nil

local function fetch_scripts_tree()
    return win32.list_dir_contents(us.directory_path .. "\\*.lua")
end

function us_unsafe.get_scripts_tree()
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

return us_unsafe
