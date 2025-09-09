local ce_settings = {}

local mod_id = "component-explorer"
local settings = {}
local computed = {}

local IS_NIL = {}

local function load_setting_value(key)
    local full_key = mod_id .. "." .. key
    local value = ModSettingGet(full_key)

    -- Seems like 'value_default=false' gets turned into nil by Noita
    if value == nil then
        return false
    end

    return value
end

function ce_settings.load()
    settings = {}
    computed = {}
end

function ce_settings.get(key)
    if settings[key] == nil then
        settings[key] = load_setting_value(key)
    end

    return settings[key]
end

function ce_settings.set(key, value)
    if ce_settings.get(key) ~= value then
        ModSettingSet(mod_id .. "." .. key, value)
        settings[key] = value
    end
end

local magic_key_labels = {
    ["ctrl+shift"] = "CTRL+SHIFT",
    ["ctrl"] = "CTRL",
    ["super"] = "SUPER",
    ["alt"] = "ALT",
}

---@generic T
---@param name string
---@param func T
---@return T
local function computed_func(name, func)
    return function()
        local cached = computed[name]
        if cached then
            if cached == IS_NIL then return nil end
            return cached
        end

        local result = func()
        if result == nil then computed[name] = IS_NIL
                         else computed[name] = result end

        return result
    end
end

---@generic T
---@param name string
---@param func T
---@return T
local function computed_func_1(name, func)
    return function(value)
        local cache = computed[name]
        if not cache then
            cache = {}
            computed[name] = cache
        end

        local cached = cache[value]
        if cached then
            if cached == IS_NIL then return nil end
            return cached
        end

        local result = func(value)
        if result == nil then cache[value] = IS_NIL
                         else cache[value] = result end

        return result
    end
end

ce_settings.magic_key_label = computed_func("magic_key_label", function()
    if not ce_settings.get("keyboard_shortcuts") then
        return nil
    end

    return magic_key_labels[ce_settings.get("magic_key")]
end)

function ce_settings.magic_keys_down()
    if not ce_settings.get("keyboard_shortcuts") then
        return false
    end

    local kd = imgui.IsKeyDown
    local keys = imgui.Key

    local magic_key = ce_settings.get("magic_key")

    if magic_key == "ctrl+shift" then
        return (kd(keys.LeftCtrl) or kd(keys.RightCtrl))
           and (kd(keys.LeftShift) or kd(keys.RightShift))
    elseif magic_key == "ctrl" then
        return kd(keys.LeftCtrl) or kd(keys.RightCtrl)
    elseif magic_key == "super" then
        return kd(keys.LeftSuper) or kd(keys.RightSuper)
    elseif magic_key == "alt" then
        return kd(keys.LeftAlt) or kd(keys.RightAlt)
    else
        print("Error unknown magic_key: " .. magic_key)
    end
end

return ce_settings
