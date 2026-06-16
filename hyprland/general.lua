-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    general = {
        border_size = 3,
        gaps_in = 5,
        gaps_out = 10,
        col = {
            active_border = catppuccin.rgba.mauve,
            inactive_border = catppuccin.rgba.surface0,
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
        extend_border_grab_area = 20,
    },
})

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "intl",
        kb_model = "",
        kb_options = "caps:escape",
        kb_rules = "",
        follow_mouse = 2,
        float_switch_override_focus = 0,
        mouse_refocus = false,
        sensitivity = -0.5,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.config({
    binds = {
        workspace_back_and_forth = false,
    },
})

hl.config({
    decoration = {
        rounding = 15,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            render_power = 10,
            color = "rgba(000000ff)",
            range = 20,
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
})

hl.config({
    dwindle = {
        preserve_split = true,
        force_split = 2,
        smart_split = false,
        preserve_split = true,
        precise_mouse_move = true,  
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        middle_click_paste = false,
        disable_splash_rendering = true,
        vrr = 1,
    },
})

hl.config({
    cursor = {
        enable_hyprcursor = true,
    },
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.config({
    opengl = {
        nvidia_anti_flicker = true,
    },
})