-- █░█ █▀ █▀▀ █▀█   █▀█ █▀█ █▀▀ █▀▀ █▀
-- █▄█ ▄█ ██▄ █▀▄   █▀▀ █▀▄ ██▄ █▀░ ▄█

-- Set your personal hyprland configuration here

-- Environment Variables
hl.env({
	mo_helpers = "$scrPath",
})

-- Monitors
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- hl.monitor({ output = "eDP-1", mode = "1920x1080@120", position = "0x0", scale = 1.2 }) -- laptop
-- hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "1600x0", scale = 1.6 })
-- hl.monitor({ output = "desc:LG Electronics LG ULTRAGEAR 308NTKF2S389", mode = "preferred", position = "0x-1152", scale = 1.25 })
-- hl.monitor({ output = "DP-1", mode = "preferred", position = "1600x0", scale = 1 })
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "1600x0", scale = 1.6 })
-- hl.monitor({ output = "desc:DHI", mode = "preferred", position = "1600x0", scale = 1 })
-- hl.monitor({ output = "desc:DHI LM24-A200Y 0x00000001", mode = "1920x1080@100.0", position = "1912x518", scale = 1.0 })
-- hl.monitor({ output = "desc:RGT", mode = "preferred", position = "1600x0", scale = 1 }) -- home screen
-- hl.monitor({ output = "desc:Samsung Display Corp. ATNA60HU01-0", mode = "2560x1600@240.0", position = "2887x1436", scale = 1.6 })
-- hl.monitor({ output = "desc:BNQ BenQ EW3270U Y1K01098019", mode = "3840x2160@60.0", position = "0x812", scale = 1.33 })

-- Workspaces
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/
hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
-- hl.workspace({ workspace = "r[1-4]", monitor = "eDP-1", default = true, gaps_out = 0 })
-- hl.workspace({ workspace = "1", monitor = "HDMI-A-1", default = true })
-- hl.workspace({ workspace = "2", monitor = "HDMI-A-1" })
-- hl.workspace({ workspace = "3", monitor = "HDMI-A-1" })

-- █░░ ▄▀█ █░█ █▄░█ █▀▀ █░█
-- █▄▄ █▀█ █▄█ █░▀█ █▄▄ █▀█

-- Autostart Apps on Core Initialization
hl.on("hyprland.start", function()
	hl.exec_cmd("solaar -w hide") -- logitech mouse
	hl.exec_cmd("kwalletd6 &")
	hl.exec_cmd("syncthing --no-browser &")

	-- hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Decay-Green'")
	-- hl.exec_cmd("waybar &")
end)

-- Compositor Settings
hl.config({
	-- Animation CPU usage fix
	animations = {
		enabled = true,
		bezier = {
			"wind, 0.05, 0.9, 0.1, 1.05",
			"winIn, 0.1, 1.1, 0.1, 1.1",
			"winOut, 0.3, -0.3, 0, 1",
			"liner, 1, 1, 1, 1",
		},
		animation = {
			"windows, 1, 6, wind, slide",
			"windowsIn, 1, 6, winIn, slide",
			"windowsOut, 1, 5, winOut, slide",
			"windowsMove, 1, 5, wind, slide",
			"border, 1, 1, liner",
			-- "borderangle, 1, 30, liner, loop",
			"fade, 1, 10, default",
			"workspaces, 1, 5, wind",
		},
	},

	input = {
		kb_layout = "fr,us",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = true,
		},
		sensitivity = 0.5,
		force_no_accel = 0,
		numlock_by_default = true,
	},

	cursor = {
		no_hardware_cursors = false,
	},

	decoration = {
		rounding = 0,
	},
})

-- Example per-device configs (Must be handled via hl.device)
hl.device({
	name = "gxtp5100:00-27c6:01e0-touchpad",
	sensitivity = 0.5,
})
