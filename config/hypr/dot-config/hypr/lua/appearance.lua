-- Look & Feel: general / decoration / dwindle / master / misc / xwayland,
-- then animations (curves + leaves), then window rules.

-- The Catppuccin palette is available for future themed borders. The active
-- config keeps the literal gradient below to preserve the exact appearance.
-- local theme = require("lua.themes")
-- e.g. a future themed border: { colors = { theme.blue, theme.green }, angle = 45 }

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 20,
    border_size = 2,
    col = {
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
    resize_on_border = false,
    allow_tearing = false,
    layout = "master",
  },
  decoration = {
    rounding = 10,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    shadow = { enabled = true, range = 4, render_power = 3, color = 0xee1a1a1a },
    blur   = { enabled = true, size = 3, passes = 1, vibrancy = 0.1696 },
  },
  dwindle = { preserve_split = true },
  master  = { new_status = "slave" },
  misc = {
    font_family = "0xProto Nerd Font",
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  },
  xwayland = { force_zero_scaling = true },
})

-- Animations
hl.config({ animations = { enabled = true } })

hl.curve("easeOutQuint",    { type = "bezier", points = { {0.23, 1},   {0.32, 1}   } })
hl.curve("easeInOutCubic",  { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}  } })
hl.curve("linear",          { type = "bezier", points = { {0, 0},      {1, 1}      } })
hl.curve("almostLinear",    { type = "bezier", points = { {0.5, 0.5},  {0.75, 1.0} } })
hl.curve("quick",           { type = "bezier", points = { {0.15, 0},   {0.1, 1}    } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Window rules. See https://wiki.hypr.land/Configuring/Window-Rules/
-- Ignore maximize requests from apps.
hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})
-- Fix some dragging issues with XWayland.
hl.window_rule({
  name = "fix-xwayland-drags",
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
})
