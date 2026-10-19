-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
-- hl.config({
--   general = {
--     -- No gaps between windows or borders.
--     gaps_in = 0,
--     gaps_out = 0,
--     border_size = 0,
--
--     -- Change to niri-like side-scrolling layout.
--     layout = "scrolling",
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
-- hl.config({
--   decoration = {
--     -- Use round window corners.
--     rounding = 8,
--
--     -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
--     dim_inactive = true,
--     dim_strength = 0.15,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- hl.config({
--   animations = {
--     -- Disable all animations.
--     enabled = false,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })

-- Window blur (Omarchy's defaults explicitly disable it).
hl.config({
	decoration = {
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			new_optimizations = true,
			-- variant = "acrylic",
		},
	},
})

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 4,
		border_size = 2,
	},
})
-- ── Smart gaps ───────────────────────────────────────────────────────────────
-- Drop the gaps and border when a workspace ends up with a single window.
-- w[tv1] = one tiled window, f[1] = one floating window.
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
o.window({ float = false, workspace = "w[tv1]" }, { border_size = 0, rounding = 0 })
o.window({ float = false, workspace = "f[1]" }, { border_size = 0, rounding = 0 })
