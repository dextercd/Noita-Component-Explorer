local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

local wiki = {}

function wiki.format_template(template_name, values, alignment)
    local param_strings = {""}
    for _, item in ipairs(values) do
        local key, value = unpack(item)
        local to_align = math.max(0, alignment - string.len(key))
        table.insert(param_strings, key .. string.rep(" ", to_align) .. " = " .. tostring(value))
    end

    local param_string = table.concat(param_strings, "\n| ")
    return "{{" .. template_name .. param_string .. "\n}}"
end

function parse_state(text)
    return {
        text = text,
        index = 1,
    }
end

function parse_error(state, text)
    error({
        state=state,
        error=text
    })
end

function spaces(state)
    local i = state.index
    while i <= #state.text do
        local chr = state.text:sub(i, i)
        if chr ~= ' ' and chr ~= '\t' and chr ~= '\r' and chr ~= '\n' then
            break
        end
        i = i + 1
    end

    state.index = i
end

function expect(state, expected)
    local actual = state.text:sub(state.index, state.index + #expected - 1)
    if actual ~= expected then
        parse_error(state, "Expected '" .. expected .. "' but got '" .. actual .. "'")
    end
    state.index = state.index + #expected
end

function readuntil(state, one_of)
    local i=state.index
    while i <= #state.text do
        for _, v in ipairs(one_of) do
            local real = state.text:sub(i, i + #v - 1)
            if real == v then
                local part = state.text:sub(state.index, i - 1)
                state.index = i
                return part
            end
        end

        i = i + 1
    end

    parse_error(state,
        "Expected one of " .. table.concat(one_of, ", ") .. " but reached end of text instead.")
end

function peek(state, count)
    return state.text:sub(state.index, state.index + count - 1)
end

function wiki.parse_template(template_text)
    local state = parse_state(template_text)
    spaces(state)
    expect(state, "{{")
    spaces(state)
    local template_name = string_util.trim(readuntil(state, {"}}", "|"}))

    local values = {}
    while true do
        if peek(state, 2) == "}}" then
            break
        end

        expect(state, "|")

        local key = string_util.trim(readuntil(state, {"="}))

        spaces(state)
        expect(state, "=")
        spaces(state)

        local value = string_util.trim(readuntil(state, {"|", "}}"}))
        table.insert(values, {key, value})
    end

    expect(state, "}}")

    return {
        template_name = template_name,
        values = values
    }
end

function wiki.normalise_name(name)
    -- Capitalise
    name = name:sub(1, 1):upper() .. name:sub(2)
    -- Use spaces
    name = name:gsub("_", " ")
    -- Collapse spaces
    name = name:gsub("  +", " ")

    return name
end

return wiki
