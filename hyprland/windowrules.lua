hl.window_rule({
    name  = "supress-maximize-events",
    match = { class = ".*"},
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "floating-kitty",
    match = { class = "kitty-floating" },
    float = true,
    center = true,
    size  = "1600 900",
})

hl.window_rule({
    name  = "vesktop_workspace",
    match = { class = "^(vesktop)$" },
    workspace = "12",
})

hl.window_rule({
    name  = "spotify_workspace",
    match = { class = "^(spotify)$" },
    workspace = "10",
})

hl.window_rule({
    name  = "open_folder",
    match = { title = "^(Open Folder)$" },
    float = true,
    center = true,
    size  = "1000 600"
})

hl.window_rule({
  name = "dolphin",
  match = { class = "^(org.kde.dolphin)$" },
  float = true,
  center = true,
  size = "1920 1080", 
})

hl.window_rule({
  name = "ark",
  match = { class = "^(org.kde.ark)$" },
  float = true,
  center = true,
  size = "1700 900",
})

hl.window_rule({
  name = "extract_ark",
  match = { title = "^(Extract - Ark)$" },
  float = true,
  center = true,
  size = "1700 900",
})

