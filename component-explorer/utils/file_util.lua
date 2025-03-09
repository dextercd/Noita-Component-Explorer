local file_util = {}

local ModDoesFileExist = ModDoesFileExist
local ModTextFileGetContent = ModTextFileGetContent

local exists_cache = {}

---@param path string
---@return boolean
function file_util.file_exists(path)
    local cached = exists_cache[path]
    if cached ~= nil then
        return cached
    end

    local exists

    if path:sub(-4) == ".png" then
        exists = ModImageDoesExist(path)
    else
        exists = ModDoesFileExist(path)
    end

    exists_cache[path] = exists
    return exists
end

file_util.ModTextFileGetContent = ModTextFileGetContent

return file_util
