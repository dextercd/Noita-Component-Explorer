local copy = {}

function copy.shallow_copy(tbl)
    local ret = {}
    for k, v in pairs(tbl) do
        ret[k] = v
    end
    return ret
end

return copy
