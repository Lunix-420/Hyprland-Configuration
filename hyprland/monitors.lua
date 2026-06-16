hl.monitor({
    output   = "DP-2",
    mode     = "3440x1440@144Hz",
    position = "0x0",
    scale    = "1.0",
    vrr      = true,
    reserved_area = {top = 0},
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "3840x2160@60Hz",
    position = "3440x0",
    scale    = "1.5",
    vrr      = true,
})