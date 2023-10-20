local helpers = {}

---Show the window only on the main viewport and start it out in the center of the screen.
function helpers.window_appear_center()
    local w, h = imgui.GetMainViewportSize()
    imgui.SetNextWindowPos(w / 2, h / 2, imgui.Cond.Appearing, 0.5, 0.5)
    imgui.SetNextWindowViewport(imgui.GetMainViewportID())
end

return helpers
