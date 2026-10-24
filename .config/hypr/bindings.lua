-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Close the focused window with SUPER+Q (Omarchy's default close is SUPER+W).
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- SUPER+RETURN was "Terminal"; make it open a tmux session instead.
-- (Omarchy's SUPER+ALT+RETURN still opens tmux as well.)
hl.unbind("SUPER + RETURN")
o.bind("SUPER + RETURN", "Tmux", { omarchy = "terminal-tmux" })

-- SUPER+W was "Close window"; now toggles the focused window between floating
-- and tiled. (Close window is SUPER+Q; Omarchy's SUPER+T does the same thing.)
hl.unbind("SUPER + W")
o.bind("SUPER + W", "Toggle floating", hl.dsp.window.float({ action = "toggle" }))

-- SUPER+E: open the file manager (Omarchy's default is SUPER+SHIFT+F).
o.bind("SUPER + E", "File manager", { omarchy = "nautilus" })

-- SUPER+B: browser; SUPER+ALT+B: private browsing (defaults use SUPER+SHIFT+B / SUPER+SHIFT+ALT+B).
o.bind("SUPER + B", "Browser", { omarchy = "browser" })
o.bind("SUPER + ALT + B", "Browser (private)", { omarchy = "browser --private" })

-- SUPER+SHIFT+P was "Google Photos in omarchy"; now takes a region screenshot.
hl.unbind("SUPER + SHIFT + P")
o.bind("SUPER + SHIFT + P", "Screenshot (region)", "omarchy capture screenshot region")
