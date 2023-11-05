local global_flag = {}

---@class GlobalFlag
---@field key string
---@field value boolean
---@field default boolean

local mt = {}
function mt:__index(key)
    if key == "value" then
        local value = GlobalsGetValue(self.key)
        if value ~= "" then
            return value == "1"
        end
        return self.default
    end
end

function mt:__newindex(key, value)
    if key == "value" then
        GlobalsSetValue(self.key, value and "1" or "0")
    end
end

---@param key string
---@param default boolean?
---@return GlobalFlag
function global_flag.new(key, default)
    return setmetatable({
        key=key,
        default=default or false,
    }, mt)
end

return global_flag
