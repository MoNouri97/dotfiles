-- HyDE marker (kept for safety, prevents overwrite)
-- $HYDE_HYPRLAND = "set"

-- =========================
-- HyDE fallback (only if needed)
-- =========================
-- NOTE: Lua Hyprland configs do NOT use "source ="
-- We use hl.import() / require() depending on build
-- require("$HOME/.local/share/hyde/hyprland.conf")

-- =========================
-- Modular config imports
-- =========================

require("./keybindings.lua")
require("./windowrules.lua")
require("./monitors.lua")
require("./userprefs.lua")
