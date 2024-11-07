local helpers = {}

function helpers.window_appear_center()
    local w, h = imgui.GetMainViewportSize()
    imgui.SetNextWindowPos(w / 2, h / 2, imgui.Cond.Appearing, 0.5, 0.5)
end

return helpers
