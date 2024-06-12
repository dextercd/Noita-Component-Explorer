local win32 = dofile_once("mods/component-explorer/unsafe/win32.lua")

-- These are offsets in the exe, not the addresses as they are loaded in memory.
local steam_identifiers = {
    {
        location = 0x00be4a3c,
        string = "Noita-Build-Apr 30 2024-14:49:50",
    },
    {
        location = 0x00d4de1a,
        string = "steam_api.dll",
    },
}

local steam_version = nil
function is_steam_version()
    if steam_version == nil then
        -- Changed to true if all checks succeed
        steam_version = false
        local nf = io.open(win32.get_exe_path(), "rb")
        if not nf then
            return false
        end

        for _, identifier in ipairs(steam_identifiers) do
            nf:seek("set", identifier.location)
            if nf:read(#identifier.string) ~= identifier.string then
                return false
            end
        end
        nf:close()

        steam_version = true
    end

    return steam_version
end
