local win32 = dofile_once("mods/component-explorer/unsafe/win32.lua")

-- These are offsets in the exe, not the addresses as they are loaded in memory.
-- Sometimes multiple versions of the game are compatible but have different
-- version strings.
local steam_identifier_sets = {
    {
        {
            location = 0x00be7498,
            string = "Noita-Build-Jan 25 2025-12:40:28",
        },
        {
            location = 0x00d50d2a,
            string = "steam_api.dll",
        },
    },
    {
        {
            location = 0x00be7498,
            string = "Noita-Build-Jan 25 2025-15:55:41",
        },
        {
            location = 0x00d50d2a,
            string = "steam_api.dll",
        },
    },
}

function check_identifiers(fh, identifiers)
    local success, result = pcall(function()
        for _, identifier in ipairs(identifiers) do
            fh:seek("set", identifier.location)
            if fh:read(#identifier.string) ~= identifier.string then
                return false
            end
        end
        return true
    end)

    if success then
        return result
    else
        print("Error checking version: " .. result)
        return false
    end
end

local steam_version = nil
function is_steam_version()
    if steam_version == nil then
        -- Changed to true if checks succeed
        steam_version = false

        local nf = io.open(win32.get_exe_path(), "rb")
        if not nf then
            return false
        end

        for _, identifiers in ipairs(steam_identifier_sets) do
            steam_version = check_identifiers(nf, identifiers)
            if steam_version then break end
        end
        nf:close()
    end

    return steam_version
end
