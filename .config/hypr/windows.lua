-- Personal window rules, loaded after Omarchy's defaults (see hyprland.lua).
-- Reference: https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- Rules are evaluated top to bottom; for a given effect the LAST match wins.

-- ── Smart gaps ───────────────────────────────────────────────────────────────
-- Drop the gaps and border when a workspace ends up with a single window.
-- w[tv1] = one tiled window, f[1] = one floating window.
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
o.window({ float = false, workspace = "w[tv1]" }, { border_size = 0, rounding = 0 })
o.window({ float = false, workspace = "f[1]" }, { border_size = 0, rounding = 0 })

-- ── Don't lock the screen while a fullscreen video plays ─────────────────────
-- Omarchy only inhibits idle for games, so a fullscreen video in a browser or
-- media player would otherwise still trigger the screensaver/lock.
o.window({ tag = "chromium-based-browser" }, { idle_inhibit = "fullscreen" })
o.window({ tag = "firefox-based-browser" }, { idle_inhibit = "fullscreen" })
o.window(
	"^(mpv|vlc|org\\.kde\\.kdenlive|com\\.github\\.rafostar\\.Clapper|[Cc]elluloid|[Ss]potify)$",
	{ idle_inhibit = "fullscreen" }
)

-- ── Godot editor ─────────────────────────────────────────────────────────────
local godot = "^(org\\.godotengine\\.Editor)$"

-- Main editor window: float at a fixed size (carried over from the old config).
-- Remove this rule if you'd rather have the editor tiled.
o.window({ class = godot }, { float = true, center = true, size = { 1200, 650 } })

-- Dialogs float + center so they don't retile the workspace. These come last so
-- their sizes win over the main-window rule above.
o.window(
	{ class = godot, title = "^(.*(Settings|Node|New|Save|Choose).*)$" },
	{ float = true, center = true, size = { 1000, 800 } }
)
o.window({ class = godot, title = "^(.*Attach Node Script.*)$" }, { float = true, center = true, size = { 530, 350 } })
o.window({ class = godot, title = "^(Alert!)$" }, { float = true, center = true, size = { 400, 500 } })

-- ── Misc floating tools ──────────────────────────────────────────────────────
o.window("^(blender|[Ll]utris|.*protonvpn.*|[Ss]ignal|eog)$", { float = true })
