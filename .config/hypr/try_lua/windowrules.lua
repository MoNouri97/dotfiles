-- =========================
-- Window Rules (Lua)
-- =========================

-- Idle inhibit
hl.window_rule({
	idle_inhibit = "fullscreen",
	match = { class = ".*celluloid.*|.*mpv.*|.*vlc.*" },
})

hl.window_rule({
	idle_inhibit = "fullscreen",
	match = { class = ".*[Ss]potify.*" },
})

hl.window_rule({
	idle_inhibit = "fullscreen",
	match = { class = ".*LibreWolf.*|.*floorp.*|.*brave-browser.*|.*firefox.*|.*chromium.*|.*zen.*|.*vivaldi.*" },
})

-- Picture-in-Picture
hl.window_rule({
	tag = "+picture-in-picture",
	match = { title = "^[Pp]icture[-%s]?[Ii]n[-%s]?[Pp]icture.*" },
})

hl.window_rule({
	float = true,
	keep_aspect_ratio = false,
	size = { "25%", "25%" },
	pin = true,
	match = { tag = "picture-in-picture" },
})

-- Opacity rules
hl.window_rule({ opacity = { 0.9, 0.9, 1 }, match = { class = "zen" } })
hl.window_rule({ opacity = { 0.9, 0.9, 1 }, match = { class = "firefox" } })
hl.window_rule({ opacity = { 0.9, 0.9, 1 }, match = { class = "brave-browser" } })

hl.window_rule({ opacity = { 0.8, 0.8, 1 }, match = { class = "code-oss" } })
hl.window_rule({ opacity = { 0.8, 0.8, 1 }, match = { class = "[Cc]ode" } })
hl.window_rule({ opacity = { 0.8, 0.8, 1 }, match = { class = "kitty" } })
hl.window_rule({ opacity = { 0.8, 0.8, 1 }, match = { class = "org.kde.dolphin" } })
hl.window_rule({ opacity = { 0.8, 0.8, 1 }, match = { class = "org.kde.ark" } })

hl.window_rule({ opacity = { 0.7, 0.7, 1 }, match = { class = "[Ss]team|steamwebhelper|[Ss]potify" } })

-- Floating apps
hl.window_rule({ float = true, match = { class = "blender" } })
hl.window_rule({ float = true, match = { class = "mpv" } })

-- Godot
hl.window_rule({
	float = true,
	size = { 400, 500 },
	center = true,
	match = { class = "org.godotengine.Editor" },
})

hl.window_rule({
	float = true,
	size = { 1000, 800 },
	center = true,
	match = { class = "org.godotengine.Editor", title = ".*Settings.*|.*Node.*|.*New.*|.*Save.*|.*Choose.*" },
})

-- JetBrains workaround
hl.window_rule({
	no_initial_focus = true,
	match = { class = ".*jetbrains.*", title = "win[0-9]+" },
})
