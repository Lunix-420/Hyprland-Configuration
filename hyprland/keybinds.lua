-- Functions for keybinds 
local function toggleFloatAndCenter()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    local win = hl.get_active_window()
    if win and win.floating then
        hl.dispatch(hl.dsp.window.resize({ x = 1600, y = 1000 }))
        hl.dispatch(hl.dsp.window.center())
    end
end

-- Window Management --
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + Tab", toggleFloatAndCenter)
hl.bind("SUPER + dead_circumflex", hl.dsp.window.center())

-- Move active --
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + UP", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.move({ direction = "down" }))

-- Change Active --
hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + UP", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "down" }))

-- Workspaces --
local workspace_keys = {
    { key = "KP_End", ws = "1" },
    { key = "KP_Down", ws = "2" },
    { key = "KP_Next", ws = "3" },
    { key = "KP_Left", ws = "4" },
    { key = "KP_Begin", ws = "5" },
    { key = "KP_Right", ws = "6" },
    { key = "KP_Home", ws = "7" },
    { key = "KP_Up", ws = "8" },
    { key = "KP_Prior", ws = "9" },
    { key = "Num_Lock", ws = "10" },
    { key = "KP_Divide", ws = "11" },
    { key = "KP_Multiply", ws = "12" },
}

for _, binding in ipairs(workspace_keys) do
    hl.bind("SUPER + " .. binding.key, hl.dsp.focus({ workspace = binding.ws }))
    hl.bind("SUPER + SHIFT + " .. binding.key, hl.dsp.window.move({ workspace = binding.ws }))
end

-- Mouse Buttons --
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

-- Screenshots --
local screenshot_keys = {
    { key = "D", mode = "output" },
    { key = "S", mode = "window" },
    { key = "A", mode = "region" },
}

for _, binding in ipairs(screenshot_keys) do
    hl.bind("SUPER + " .. binding.key, function() 
        hl.dispatch(hl.dsp.exec_cmd("hyprshot -m " .. binding.mode .. " --freeze --clipboard-only"))
        hl.dispatch(hl.dsp.exec_cmd("killall hyprpicker"))
        hl.dispatch(hl.dsp.exec_cmd("notify-send 'Screenshot taken' --app-name='Hyprshot' --expire-time=2000"))
    end)
end

-- Color Picker --
hl.bind("SUPER + P", hl.dsp.exec_cmd("hyprpicker -f hex -a"))

-- Quickshell
hl.bind("SUPER + B", function()
    hl.dispatch(hl.dsp.exec_cmd(
        "killall quickshell || \
         quickshell --path /data/development/quickshell --no-duplicate --daemonize"))
end)


-- Terminal --
hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd("kitty --class='kitty-floating'"))

-- Launcher --
hl.bind("SUPER + L", function()
    hl.dispatch(hl.dsp.exec_cmd(
        "pkill fuzzel || \
         fuzzel --config=$HOME/.config/hypr/fuzzel/fuzzel.ini --log-level=info"))
end)


-- Apps --
hl.bind("SUPER + K", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + J", hl.dsp.exec_cmd(files))
hl.bind("SUPER + M", hl.dsp.exec_cmd(ide))
hl.bind("SUPER + Slash", hl.dsp.exec_cmd(volume))