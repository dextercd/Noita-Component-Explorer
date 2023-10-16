local lua_appends = {}

---@param path string Path to the script you want to get appends of
---@return string[]
local function impl_get(path)
    local result = {}

    dofile = function(appended)
        table.insert(result, appended)
    end

    do_mod_appends(path)

    return result
end

---Returns the Lua files that were appended to the given script
---@param path string Path to the script you want to get appends of
---@return string[]
function lua_appends.get(path)
    local dofile_restore = dofile
    local status, ret = pcall(impl_get, path)
    dofile = dofile_restore

    if not status then
        error(ret)
    end

    return ret
end

---@alias recursive_appends {path: string, appends: recursive_appends[]}

---@param path string
---@param maxdepth integer
---@return recursive_appends[]
local function impl_get_recursive(path, maxdepth)
    if maxdepth == 0 then
        return {}
    end

    ---@type recursive_appends[]
    local result = {}

    local dofile_restore = dofile

    dofile = function(appended)
        table.insert(result,
            {
                path = appended,
                appends = impl_get_recursive(appended, maxdepth - 1),
            }
        )
    end

    do_mod_appends(path)

    dofile = dofile_restore

    return result
end

---@param path string Path to the script you want to get appends of
---@param maxdepth integer? Maximum depth it will try to resolve the appends to. Defaults to 10
---@return recursive_appends[] appends Nested list of appended scripts
function lua_appends.get_recursive(path, maxdepth)
    maxdepth = maxdepth or 10

    local dofile_restore = dofile
    local status, ret = pcall(impl_get_recursive, path, maxdepth)
    dofile = dofile_restore

    if not status then
        error(ret)
    end

    return ret
end


return lua_appends
