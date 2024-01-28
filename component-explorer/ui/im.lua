local im = {}

---@type Window?
local _curr_window

---@return Window?
function im.CurrentWindow()
    return _curr_window
end

---@class OpenData
---@field pos number[]?
---@field size number[]?
---@field dock_id integer?

---@class Window
---@field id string
---@field open boolean
---@field flags WindowFlags
---@field open_data OpenData?

---@param id string
---@param open boolean
---@param flags WindowFlags?
---@param open_data OpenData?
---@return Window
function im.Window(id, open, flags, open_data)
    return {
        id=id,
        open=open or false,
        flags=flags or 0,
        open_data=open_data,
    }
end

---@param window Window
---@param name string?
---@param flags WindowFlags?
---@return boolean should_show
function im.Begin(window, name, flags)
    if window.open == false then
        return false
    end

    local od = window.open_data
    if od then
        window.open_data = nil
        if od.pos then imgui.SetNextWindowPos(unpack(od.pos)) end
        if od.size then imgui.SetNextWindowSize(unpack(od.size)) end
        if od.dock_id then imgui.SetNextWindowDockID(od.dock_id) end
    else
        imgui.SetNextWindowSize(600, 400, imgui.Cond.FirstUseEver)
    end

    flags = bit.bor(flags or 0, window.flags)
    name = (name or "") .. window.id

    local should_show
    should_show, window.open = imgui.Begin(name, window.open, flags)

    if should_show then
        _curr_window = window
    end

    return should_show
end

---@param window Window
function im.End(window)
    if _curr_window == window then
        _curr_window = nil
    end

    imgui.End()
end

---@return OpenData
function im.GetOpenData()
    local open_data = {}

    local curr_window = im.CurrentWindow()

    if imgui.IsKeyDown(imgui.Key.LeftCtrl) then
        if curr_window then
            curr_window.open = false
            if imgui.GetWindowDockID then
                local dock_id = imgui.GetWindowDockID()
                if dock_id ~= 0 then
                    open_data.dock_id = dock_id
                end
            end
        end

        if not open_data.dock_id then
            open_data.pos = {imgui.GetWindowPos()}
            open_data.size = {imgui.GetWindowSize()}
        end
    elseif imgui.IsKeyDown(imgui.Key.LeftShift) then
        local dock_id = 0
        if imgui.GetWindowDockID then
            dock_id = imgui.GetWindowDockID()
            if dock_id == 0 and curr_window and imgui.DockBuilderAddNode then
                dock_id = imgui.DockBuilderAddNode()
                imgui.DockBuilderSetNodePos(dock_id, imgui.GetWindowPos())
                imgui.DockBuilderSetNodeSize(dock_id, imgui.GetWindowSize())
                imgui.DockBuilderDockWindow(curr_window.id, dock_id)
                imgui.DockBuilderFinish(dock_id)
            end
        end

        if dock_id ~= 0 then
            open_data.dock_id = dock_id
        else
            open_data.pos = {imgui.GetWindowPos()}
            open_data.size = {imgui.GetWindowSize()}
        end
    end

    return open_data
end

return im
