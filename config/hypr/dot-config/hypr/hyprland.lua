-- ~/.config/hypr/hyprland.lua
-- Hyprland compositor config (Lua). Loaded in preference to hyprland.conf;
-- rename/remove this file to fall back to the hyprlang config.
--
-- workspaces and programs return tables consumed by input.lua, which
-- re-requires them (require caches modules, so they load once).
require("lua.themes")      -- palette available (structural; future use)
require("lua.monitors")
require("lua.workspaces")
require("lua.programs")
require("lua.environment")
require("lua.appearance")
require("lua.input")
