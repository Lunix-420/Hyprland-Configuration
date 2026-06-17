-- Left monitor workspaces
for i = 1, 6 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "DP-2",
        persistent = true,
    })
end

-- Right monitor workspaces
for i = 7, 12 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "HDMI-A-1",
        persistent = true,
    })
end

-- Initialize workspaces by focusing on each one
local function init_workspaces()
  for i = 1, 12 do
    hl.dispatch(hl.dsp.focus({workspace = tostring(i)}))
  end
  hl.dispatch(hl.dsp.focus({workspace = "7"}))
end
