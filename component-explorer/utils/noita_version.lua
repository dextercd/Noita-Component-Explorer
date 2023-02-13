dofile_once("mods/component-explorer/utils/win32.lua")

local steam_identifiers = {
    {
        location = 0x00a392ac,
        string = "Noita-Build-Apr 23 2021-18:44:24",
    },
    {
        location = 0x00b37e4c,
        string = "steam_api.dll",
    },
}

local steam_version = nil
function is_steam_version()
    if steam_version == nil then
        -- Changed to true if all checks succeed
        steam_version = false
        local nf = io.open(get_exe_path(), "rb")

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
