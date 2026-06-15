-- Input + per-device config + all keybindings.

local ws = require("lua.workspaces") -- workspace numbers + ws.mod
local apps = require("lua.programs") -- command strings

local mainMod = "SUPER"
local secondMod = "SUPER + SHIFT" -- was $secondMod = SUPERSHIFT
local wsMod = ws.mod -- "CTRL_SHIFT"

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        touchpad = { natural_scroll = false },
    },
})

-- Per-device config.
hl.device({ name = "logitech-usb-receiver-mouse", sensitivity = -0.5, accel_profile = "flat" })

------------------------------------------------------------------------------
-- Keybindings
------------------------------------------------------------------------------

-- Audio controls (no modifier; map to laptop keys)
hl.bind("F6", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("F5", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("F3", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Spotify controls (112 PgUp, 117 PgDn, 115 End)
hl.bind(mainMod .. " + code:112", hl.dsp.exec_cmd("spotify_player playback next"))
hl.bind(mainMod .. " + code:117", hl.dsp.exec_cmd("spotify_player playback previous"))
hl.bind(mainMod .. " + code:115", hl.dsp.exec_cmd("spotify_player playback play-pause"))

-- Screenshots (grim). Shell substitutions are evaluated at runtime.
hl.bind("Print", hl.dsp.exec_cmd([[grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')]]))
hl.bind(secondMod .. " + P", hl.dsp.exec_cmd([[grim -g "$(slurp)"]]))

-- Lock screen + core apps
hl.bind(secondMod .. " + Q", hl.dsp.exec_cmd(apps.lock_screen))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(apps.terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(apps.browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(apps.browser .. " https://claude.ai"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(apps.file_manager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(apps.menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- App launchers onto specific workspaces (was bind = $workspaceMod, …, exec, [workspace $x] …)
hl.bind(
    wsMod .. " + S",
    hl.dsp.exec_cmd(
        [[uwsm app -- ghostty --initial-command="tmux new -A -s spotify /usr/bin/spotify_player"]],
        { workspace = ws.music }
    )
)
hl.bind(
    wsMod .. " + N",
    hl.dsp.exec_cmd(
        [[uwsm app -- ghostty --initial-command="cd ~/code/my-notes/ && tmux new -A -s notes"]],
        { workspace = ws.notes }
    )
)
hl.bind(wsMod .. " + D", hl.dsp.exec_cmd(apps.discord, { workspace = ws.social }))
hl.bind(wsMod .. " + E", hl.dsp.exec_cmd(apps.element, { workspace = ws.social }))
hl.bind(wsMod .. " + B", hl.dsp.exec_cmd(apps.browser, { workspace = ws.browser }))
-- Switch workspaces (mainMod + [1-9,0]) and move active window (mainMod + SHIFT + …).
-- Key 0 maps to workspace 10; reproduces the source key→workspace mapping.
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize active window with secondMod + arrow keys
hl.bind(secondMod .. " + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
hl.bind(secondMod .. " + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
hl.bind(secondMod .. " + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
hl.bind(secondMod .. " + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))

-- Laptop multimedia keys for volume and LCD brightness (locked + repeating)
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media keys (requires playerctl; locked)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
