-- Programs + Autostart.
-- Returns the `apps` table so input.lua can share the command strings.

local ws = require("lua.workspaces")

local apps = {
  terminal     = "uwsm app -- ghostty",
  file_manager = "uwsm app -- nautilus",
  menu         = "uwsm app -- wofi --show drun",
  status_bar   = "uwsm app -- waybar",
  lock_screen  = "uwsm app -- hyprlock --immediate",
  browser      = "uwsm app -- flatpak run com.brave.Browser",
  discord      = "uwsm app -- flatpak run com.discordapp.Discord",
  element      = "uwsm app -- flatpak run im.riot.Riot",
}

-- Autostart. exec-once lines run on compositor start. The second argument to
-- hl.exec_cmd is a window rule applied to the spawned window; `workspace`
-- assigns it to a workspace (replaces the old `[workspace N] cmd` prefix).
hl.on("hyprland.start", function()
  hl.exec_cmd("uwsm app -- wl-paste --watch cliphist store")
  hl.exec_cmd(apps.terminal, { workspace = ws.main })
  hl.exec_cmd(apps.browser .. " https://claude.ai", { workspace = ws.browser })
  hl.exec_cmd([[uwsm app -- ghostty --initial-command="tmux new -A -s btop /usr/bin/btop"]], { workspace = ws.sys_monitor })
end)

return apps
