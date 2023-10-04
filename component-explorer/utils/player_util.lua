local player_util = {}


function player_util.get_player()
    return EntityGetWithTag("player_unit")[1]
end

return player_util
