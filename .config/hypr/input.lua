-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Adopted from the old HyDE config (userprefs.conf in
-- dotfiles-hypr-backup-20261018-220920.tar.gz): natural scrolling plus the
-- touchpad sensitivity this machine was tuned with.
--
-- Touchpad `sensitivity` is only honoured while acceleration is enabled, so
-- force_no_accel = 0 (Hyprland's default) must stay for the device block below
-- to have any effect.
hl.config({
	input = {
		force_no_accel = 0,

		touchpad = {
			-- Natural (inverse) scrolling.
			natural_scroll = true,
		},
	},
})

-- Touchpad sensitivity, scoped to the touchpad only so the external Logitech
-- mouse keeps Omarchy's default pointer feel (global input.sensitivity = 0.5
-- would change the mouse too).
hl.device({
	name = "gxtp5100:00-27c6:01e0-touchpad",
	sensitivity = 0.5,
})

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
-- hl.config({
--   input = {
--     -- Use multiple keyboard layouts and switch between them with Left Alt + Right Alt.
--     kb_layout = "us,dk,eu",
--     kb_options = "compose:caps,shift:both_capslock_cancel,grp:alts_toggle",
--
--     -- Use a specific keyboard variant if needed (e.g. intl for international keyboards).
--     kb_variant = "intl",
--
--     -- Change speed of keyboard repeat.
--     repeat_rate = 40,
--     repeat_delay = 250,
--
--     -- Start with numlock on by default.
--     numlock_by_default = true,
--
--     -- Increase sensitivity for mouse/trackpad (default: 0).
--     sensitivity = 0.35,
--
--     -- Turn off mouse acceleration (default: adaptive).
--     accel_profile = "flat",
--
--     touchpad = {
--       -- Use natural (inverse) scrolling.
--       natural_scroll = true,
--
--       -- Use two-finger clicks for right-click instead of lower-right corner.
--       clickfinger_behavior = true,
--
--       -- Control the speed of your scrolling.
--       scroll_factor = 0.4,
--
--       -- Enable the touchpad while typing.
--       disable_while_typing = false,
--
--       -- Left-click-and-drag with three fingers.
--       drag_3fg = 1,
--     },
--   },
-- })

-- App-specific touchpad scroll speeds.
-- o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
-- o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Three-finger horizontal swipe switches workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- If the direction feels backwards with natural scrolling, add:
--   hl.config({ gestures = { workspace_swipe_invert = false } })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout).
-- hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
-- hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })
