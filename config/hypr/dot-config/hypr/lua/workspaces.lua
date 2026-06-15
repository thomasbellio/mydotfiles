-- Workspaces. Replaces workspace.conf.
-- Returns the `ws` table so input.lua can reuse the numbers and the modifier.

local ws = {
    main = 1,
    browser = 2,
    sys_monitor = 3,
    music = 4,
    notes = 5,
    social = 6,
    broadcasting = 7,
    video_editor = 8,
    stream_browser = 9,
    comms = 10,
    mod = "CTRL + SHIFT", -- was $workspaceMod
}

-- Workspace rules (see https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/)
hl.workspace_rule({ workspace = ws.main, default_name = "Main(1)", default = true, monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = ws.browser, default_name = "Browser(2)", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = ws.sys_monitor, default_name = "SysMonitor(3)", monitor = "eDP-1" })
hl.workspace_rule({ workspace = ws.music, default_name = "Music(4)", monitor = "eDP-1" })
hl.workspace_rule({ workspace = ws.notes, default_name = "Notes(5)", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = ws.social, default_name = "Social(6)", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = ws.broadcasting, default_name = "Broadcast(7)", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = ws.video_editor, default_name = "VEditor(8)", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = ws.stream_browser, default_name = "StrBrowser(9)", monitor = "eDP-1" })
hl.workspace_rule({ workspace = ws.comms, default_name = "Comms(10)", monitor = "eDP-1" })

return ws
