-- Personal window rules, loaded after Omarchy's defaults (see hyprland.lua).
-- Reference: https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- Rules are evaluated top to bottom; for a given effect the LAST match wins.

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

-- ── Messenger call popup ─────────────────────────────────────────────────────
-- The messenger.com call window shares its class with the main Messenger
-- window, and Chromium opens it as "about:blank" — the title only becomes
-- "Messenger call" once the call page has loaded. Static rules match
-- initial_title, so a plain o.window() can never catch it; react to the title
-- change instead and force it to a small floating window.
local messenger_class = "chrome%-www%.messenger%.com"
local messenger_call_title = "^Messenger call$"

local function is_messenger_call(w)
	if not (w and w.class and w.title) then
		return false
	end

	return w.class:find(messenger_class) ~= nil and w.title:find(messenger_call_title) ~= nil
end

local function float_messenger_call(w)
	if not is_messenger_call(w) then
		return
	end

	hl.dispatch(hl.dsp.window.float({ action = "set", window = w }))
	hl.dispatch(hl.dsp.window.resize({ x = 580, y = 460, window = w }))
	hl.dispatch(hl.dsp.window.center({ window = w }))
end

hl.on("window.title", float_messenger_call)
hl.on("window.open", float_messenger_call)
