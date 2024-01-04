local file_util = {}

local ModDoesFileExist = ModDoesFileExist
local GuiGetImageDimensions = GuiGetImageDimensions
local ModTextFileGetContent = ModTextFileGetContent

local exists_cache = {}

if ModDoesFileExist then
    ---@param path string
    ---@return boolean
    local function caching_does_file_exist(path)
        local cached = exists_cache[path]
        if cached ~= nil then
            return cached
        end

        local exists = ModDoesFileExist(path)
        exists_cache[path] = exists
        return exists
    end

    file_util.image_file_exists = caching_does_file_exist
    file_util.text_file_exists = caching_does_file_exist
else
    local gui = GuiCreate()
    ---@param path string
    ---@return boolean
    function file_util.image_file_exists(path)
        local cached = exists_cache[path]
        if cached ~= nil then
            return cached
        end

        GuiStartFrame(gui)
        local w = GuiGetImageDimensions(gui, path)
        local exists = w ~= 0

        exists_cache[path] = exists
        return exists
    end

    ---@param path string
    ---@return boolean
    function file_util.text_file_exists(path)
        local cached = exists_cache[path]
        if cached ~= nil then
            return cached
        end

        local content = ModTextFileGetContent(path)
        local exists = content ~= nil and content ~= ""

        exists_cache[path] = exists
        return exists
    end
end

file_util.ModTextFileGetContent = ModTextFileGetContent

return file_util
