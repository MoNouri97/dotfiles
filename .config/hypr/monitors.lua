-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 1.6

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- BenQ 4K sits LEFT of the laptop.
-- Logical width = 3840 / 1.6 = 2400, so it occupies x = -2400 .. 0.
-- The port name moves between DP-1/DP-3 depending on the cable, so match both.
hl.monitor({ output = "DP-1", mode = "3840x2160@60", position = "-2400x0", scale = omarchy_monitor_scale })
hl.monitor({ output = "DP-3", mode = "3840x2160@60", position = "-2400x0", scale = omarchy_monitor_scale })

-- eDP-1 (laptop) stays at the origin.
hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1.25 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
