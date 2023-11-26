---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.unsafe.win32'
local win32 = dofile_once("mods/component-explorer/unsafe/win32.lua")

---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

local ffi = require("ffi")
local C = ffi.C

local logger = {}

local function open_log_file()
    local log_handle = C.CreateFileA(
        "logger.txt",
        win32.DesiredAccess.GENERIC_READ,
        bit.bor(
            win32.ShareMode.FILE_SHARE_READ,
            win32.ShareMode.FILE_SHARE_WRITE,
            win32.ShareMode.FILE_SHARE_DELETE),
        nil,
        win32.CreationDisposition.OPEN_EXISTING,
        bit.bor(
            win32.FileAttribute.FILE_ATTRIBUTE_NORMAL,
            win32.FileAttribute.FILE_FLAG_OVERLAPPED),
        nil
    )

    if log_handle == win32.INVALID_HANDLE_VALUE then
        local last_error = C.GetLastError()
        error("CreateFileA " .. last_error .. win32.format_message(last_error))
    end

    return win32.HandleLifetime(log_handle)
end

local log_file
local function log_handle()
    if log_file == nil then
        log_file = open_log_file()
    end
    return log_file.handle
end

local lines = {""}
local remove_log_items = nil

event = win32.HandleLifetime(C.CreateEventA(nil, true, false, nil))
local overlapped = ffi.new("OVERLAPPED")
overlapped.hEvent = event.handle

local read_buffer = ffi.new("char[2048]")
local async_pending = false

local function process_read_response(size)
    local log_text = ffi.string(read_buffer, size)
    local first = nil
    for line in string_util.split_iter(log_text, "\n", true) do
        if first == nil then
            first = line
            lines[#lines] = lines[#lines] .. first
        else
            table.insert(lines, line)
        end
    end

    async_pending = false
    local offset = ffi.cast("intptr_t", overlapped.DUMMYUNIONNAME.Pointer)
    local new_offset = offset + size
    overlapped.DUMMYUNIONNAME.Pointer = ffi.cast("PVOID", new_offset)
end

local function read_overlapped_result()
    local number_of_bytes = ffi.new("DWORD[1]")
    local result = C.GetOverlappedResult(log_handle(), overlapped, number_of_bytes, false)
    local last_error = C.GetLastError()
    if result ~= 0 then
        process_read_response(number_of_bytes[0])
        return true
    elseif last_error == win32.WinError.ERROR_IO_PENDING then
        return false
    elseif last_error == win32.WinError.ERROR_HANDLE_EOF then
        async_pending = false
    else
        error("GetOverlappedResult " .. win32.format_message(last_error))
    end
end

local function read_logs()
    if not async_pending then
        local result = C.ReadFile(
            log_handle(),
            read_buffer,
            ffi.sizeof(read_buffer),
            nil,
            overlapped
        )

        local last_error = C.GetLastError()
        if result == 0 and last_error ~= win32.WinError.ERROR_IO_PENDING then
            error("ReadFile " .. win32.format_message(last_error))
        end

        async_pending = true
    end

    local wait_result = C.WaitForSingleObject(event.handle, 0)
    if wait_result == 0 then
        assert(C.ResetEvent(event.handle) ~= 0)
        read_overlapped_result()
    elseif wait_result ~= 0x102 then -- not timeout
        error("WaitForSingleObject " .. win32.format_message(C.GetLastError()))
    end
end

local function update_logs()
    read_logs()

    if remove_log_items then
        local with_items_removed = {}
        for i=remove_log_items+1,#lines do
            table.insert(with_items_removed, lines[i])
        end
        lines = with_items_removed
        remove_log_items = nil
    end
end

local function get_log_lines(line_nr, around)
    around = around or 0
    local start = line_nr - around
    if start < 1 then start =1 end

    local end_ = line_nr + around
    if end_ > #lines then end_ = #lines end

    local text = ""
    for i=start,end_ do
        text = text .. lines[i] .. "\n"
    end

    return text
end

local function copy_log_lines(line_nr, around)
    imgui.SetClipboardText(get_log_lines(line_nr, around))
end

local function log_item_context_menu(line_nr)
    if not imgui.BeginPopupContextItem(tostring(line_nr)) then
        return
    end

    if imgui.MenuItem("Copy") then
        copy_log_lines(line_nr)
    end

    if imgui.MenuItem("Copy two surrounding lines") then
        copy_log_lines(line_nr, 2)
    end

    if imgui.MenuItem("Copy five surrounding lines") then
        copy_log_lines(line_nr, 5)
    end

    if imgui.MenuItem("Remove this history") then
        remove_log_items = line_nr
    end

    imgui.EndPopup()
end

local function line_colour(str)
    if string_util.ifind(str, "erro") or
       string_util.ifind(str, "problem") or
       string_util.ifind(str, "fail") or
       string_util.ifind(str, "OOPSIE WOOPSIE") or
       string_util.ifind(str, "We made a fucky wucky") or
       string_util.ifind(str, "critical")
    then
        return unpack(style.colour_fail)
    end

    if string_util.ifind(str, "warn") or
       string_util.ifind(str, "couldn't") or
       string_util.ifind(str, "missing")
    then
        return unpack(style.colour_warn)
    end
end

local function draw_log_text(autoscroll, capture_input)
    if capture_input == nil then capture_input = true end

    local flags = 0

    if autoscroll then
        flags = bit.bor(
            flags,
            imgui.WindowFlags.NoScrollbar,
            imgui.WindowFlags.NoScrollWithMouse
        )
    end

    if not capture_input then
        flags = bit.bor(
            flags,
            imgui.WindowFlags.NoInputs
        )
    end

    if imgui.BeginChild("Log lines", 0, 0, false, flags) then
        local count = #lines
        local include_last_line = lines[#lines] ~= ""
        if not include_last_line then
            count = count - 1
        end

        local clipper = imgui.ListClipper.new()
        clipper:Begin(count)

        while clipper:Step() do
            for i=clipper.DisplayStart,clipper.DisplayEnd - 1 do
                local line_nr = i + 1
                local line = lines[line_nr]
                local r,g,b,a = line_colour(line)
                if r then
                    imgui.PushStyleColor(imgui.Col.Text, r, g, b, a)
                end

                imgui.Text(line)
                log_item_context_menu(line_nr)

                if r then
                    imgui.PopStyleColor()
                end
            end
        end

        if autoscroll then
            imgui.SetScrollHereY(1)
        end

        imgui.EndChild()
    end
end

local window_autoscroll = true

logger.window_open = ce_settings.get("window_open_logs") --[[@as boolean]]
logger.overlay_open = ce_settings.get("overlay_open_logs") --[[@as boolean]]

function logger.show_window()
    local should_show
    should_show, logger.window_open = imgui.Begin("logger.txt", logger.window_open)

    if not should_show then
        return
    end

    update_logs()
    _, window_autoscroll = imgui.Checkbox("Auto scroll", window_autoscroll)
    draw_log_text(window_autoscroll)
    imgui.End()
end

function logger.show_overlay()
    update_logs()

    local flags = bit.bor(
        imgui.WindowFlags.NoDecoration,
        imgui.WindowFlags.NoScrollWithMouse,
        imgui.WindowFlags.NoInputs,
        imgui.WindowFlags.NoDocking,
        imgui.WindowFlags.AlwaysAutoResize,
        imgui.WindowFlags.NoSavedSettings,
        imgui.WindowFlags.NoFocusOnAppearing,
        imgui.WindowFlags.NoNav,
        imgui.WindowFlags.NoMove
    )

    local vw, vh = imgui.GetMainViewportSize()
    local vx, vy = imgui.GetMainViewportWorkPos()

    local reserve_top = vh * 0.12
    local reserve_bottom = 20
    local reserve_left = 20

    local width = math.min(.6 * vw, 800)
    local height = vh - reserve_top - reserve_bottom
    if height < 30 then
        return
    end

    imgui.SetNextWindowPos(vx + reserve_left, vy + reserve_top)
    imgui.SetNextWindowSize(width, height)

    imgui.SetNextWindowBgAlpha(0.25)
    imgui.SetNextWindowViewport(imgui.GetMainViewportID())
    if imgui.Begin("log overlay", nil, flags) then
        draw_log_text(true, false)
        imgui.End()
    end
end

return logger
