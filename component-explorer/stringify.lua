dofile_once("mods/component-explorer/copy.lua")

function quote_string(str)
    local escaped = str:gsub('(["\\])', "\\%1")
    return '"' .. escaped .. '"'
end

local function stringify_impl(obj, indent, location, handled_tables)
    local switch = {
        ['function'] = tostring,
        ['nil'] = tostring,
        ['boolean'] = tostring,
        ['number'] = tostring,
        ['string'] = quote_string,
        ['userdata'] = tostring,
        ['thread'] = tostring,
        ['table'] = function(obj)
            if handled_tables[obj] ~= nil then
                return 'already handled (' .. handled_tables[obj] .. ')'
            end

            local sub_handled = shallow_copy(handled_tables)
            sub_handled[obj] = location


            local innerindentstr = string.rep('  ', indent + 1)
            local indentstr = string.rep('  ', indent)

            local str = ''
            for n, o in pairs(obj) do
                str = str .. innerindentstr .. n .. ' = ' ..
                    stringify_impl(o, indent + 1, location .. '/' .. n, sub_handled) .. '\n'
            end

            return '{\n' .. str .. indentstr .. '}'
        end
    }

    return (switch[type(obj)] or tostring)(obj);
end

function stringify(obj)
    return stringify_impl(obj, 0, 'base', {})
end
