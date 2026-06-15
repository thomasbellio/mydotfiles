-- Monitors. See https://wiki.hypr.land/Configuring/Monitors/
-- monitor=name, resolution, position, scale
hl.monitor({ output = "eDP-1",    mode = "preferred", position = "0x0",        scale = "auto" })
hl.monitor({ output = "HDMI-A-3", mode = "preferred", position = "auto-right", scale = "auto" })

-- Alternative placement kept for parity with the original config:
-- hl.monitor({ output = "HDMI-A-3", mode = "preferred", position = "auto-left", scale = "auto" })
-- Negative values for position are based on the monitor's resolution and ensure the
-- monitor is positioned exactly 3440 pixels left of the laptop monitor and 1440 up,
-- allowing more precise positioning.
