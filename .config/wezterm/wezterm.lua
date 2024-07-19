local wezterm = require("wezterm")
return {
	window_padding = {
		left = 2,
		right = 2,
		top = 0,
		bottom = 0,
	},
	-- color_scheme = "Chalk (base16)",
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	-- font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" }),
	-- font = wezterm.font("Agave Nerd Font Mono"),
	font = wezterm.font("zed mono extended"),
	font_size = 16,
	cell_width = 0.9,
	-- line_height = 1.2,
	-- font_antialias = "Subpixel",
	freetype_load_target = "Normal",
	-- freetype_render_target = "HorizontalLcd",
	-- macos_window_background_blur = 40,
	macos_window_background_blur = 30,

	-- window_background_image = '/Users/omerhamerman/Downloads/3840x1080-Wallpaper-041.jpg',
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	-- window_background_opacity = 0.92,
	window_background_opacity = 0.95,
	-- window_background_opacity = 0.78,
	-- window_background_opacity = 0.20,
	window_decorations = "RESIZE",
	keys = {
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
