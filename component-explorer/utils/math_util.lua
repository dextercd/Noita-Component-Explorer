local math_util = {}

---@param a string
---@return string
function math_util.int64_clamp(a)
    local an = tonumber(a)
    if an == nil then return "0" end
    if an >= 2^63 then return "9223372036854775807" end
    if an < -2^63 then return "-9223372036854775808" end
    return a
end

---@param a string
---@return string
function math_util.uint64_clamp(a)
    local an = tonumber(a)
    if an == nil then return "0" end
    if an >= 2^64 then return "18446744073709551615" end
    if an < 0 then return "0" end
    return a
end

---@param a number
---@param min number
---@param max number
function math_util.clamp(a, min, max)
    if a < min then return min end
    if a > max then return max end
    return a
end

return math_util
