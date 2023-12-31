local player_util = {}

---@return integer?
function player_util.get_player()
    local p = EntityGetWithTag("player_unit")[1]
    if p then
        return p
    end

    return EntityGetWithTag("polymorphed_player")[1]
end

return player_util
