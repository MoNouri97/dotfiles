-- =========================
-- Keybindings (Lua version)
-- =========================

local mainMod = "SUPER"

-- Apps
local term = "kitty tmux"
local editor = "kitty nvim"
local nvim = "kitty nvim"
local file = "dolphin"
local browser = "zen-browser"

local scrPath = os.getenv("scrPath") or ""

-- =========================
-- Window / session actions
-- =========================

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(scrPath .. "/dontkillsteam.sh"))
hl.bind("ALT + F4", hl.dsp.exec_cmd(scrPath .. "/dontkillsteam.sh"))

hl.bind(mainMod .. " + DELETE", hl.dsp.exit())

hl.bind(mainMod .. " + W", hl.dsp.window.toggle_floating())
hl.bind(mainMod .. " + G", hl.dsp.window.toggle_group())
hl.bind("ALT + RETURN", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd(scrPath .. "/windowpin.sh"))
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd(scrPath .. "/logoutlaunch.sh"))
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd("killall waybar || waybar"))

-- =========================
-- Application shortcuts
-- =========================

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(file))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(nvim))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))

hl.bind("CTRL + SHIFT + ESCAPE", hl.dsp.exec_cmd(scrPath .. "/sysmonlaunch.sh"))

-- =========================
-- Rofi menus
-- =========================

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh d"))
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh w"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh f"))

-- =========================
-- Audio
-- =========================

hl.bind("F10", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"))
hl.bind("F11", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"))
hl.bind("F12", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -i m"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"))

-- =========================
-- Media
-- =========================

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- =========================
-- Brightness
-- =========================

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh i"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh d"))

-- =========================
-- Group navigation
-- =========================

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.change_group({ dir = "b" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.change_group({ dir = "f" }))

-- =========================
-- Screenshots
-- =========================

hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("~/dotfiles/my-scripts/screenshot_notify.sh"))

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh s"))
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh sf"))
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh m"))
hl.bind("PRINT", hl.dsp.exec_cmd(scrPath .. "/screenshot.sh p"))

-- =========================
-- Custom scripts
-- =========================

hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd(scrPath .. "/gamemode.sh"))
hl.bind(mainMod .. " + ALT + RIGHT", hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -n"))
hl.bind(mainMod .. " + ALT + LEFT", hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -p"))
hl.bind(mainMod .. " + ALT + UP", hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh n"))
hl.bind(mainMod .. " + ALT + DOWN", hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh p"))

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/wallbashtoggle.sh -m"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/themeselect.sh"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofiselect.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/swwwallselect.sh"))

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh -c"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(scrPath .. "/keyboardswitch.sh"))

hl.bind(mainMod .. " + CTRL + G", hl.dsp.exec_cmd("~/dotfiles/my-scripts/godotWorkspace.sh"))

-- =========================
-- Links
-- =========================

hl.bind("SUPER + G", hl.dsp.exec_cmd("xdg-open https://chatgpt.com"))

-- =========================
-- Focus movement
-- =========================

hl.bind(mainMod .. " + LEFT", hl.dsp.window.move_focus("l"))
hl.bind(mainMod .. " + RIGHT", hl.dsp.window.move_focus("r"))
hl.bind(mainMod .. " + UP", hl.dsp.window.move_focus("u"))
hl.bind(mainMod .. " + DOWN", hl.dsp.window.move_focus("d"))

hl.bind("ALT + TAB", hl.dsp.window.move_focus("d"))

-- =========================
-- Workspaces
-- =========================

for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.workspace(i))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
	hl.bind(mainMod .. " + ALT + " .. i, hl.dsp.window.movetoworkspace_silent(i))
end

hl.bind(mainMod .. " + 0", hl.dsp.workspace(10))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.movetoworkspace(10))
hl.bind(mainMod .. " + ALT + 0", hl.dsp.window.movetoworkspace_silent(10))

-- =========================
-- Relative workspaces
-- =========================

hl.bind(mainMod .. " + CTRL + RIGHT", hl.dsp.workspace({ direction = "r+1" }))
hl.bind(mainMod .. " + CTRL + LEFT", hl.dsp.workspace({ direction = "r-1" }))

hl.bind(mainMod .. " + CTRL + ALT + RIGHT", hl.dsp.window.movetoworkspace({ direction = "r+1" }))
hl.bind(mainMod .. " + CTRL + ALT + LEFT", hl.dsp.window.movetoworkspace({ direction = "r-1" }))

hl.bind(mainMod .. " + CTRL + DOWN", hl.dsp.workspace({ mode = "empty" }))

-- =========================
-- Resize
-- =========================

hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.window.resizeactive({ x = 30, y = 0 }))
hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.window.resizeactive({ x = -30, y = 0 }))
hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.window.resizeactive({ x = 0, y = -30 }))
hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.window.resizeactive({ x = 0, y = 30 }))

-- =========================
-- Mouse binds
-- =========================

hl.bind("mouse:272", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"), { mouse = true })
hl.bind("mouse:273", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"), { mouse = true })

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
