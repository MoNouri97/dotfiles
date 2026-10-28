-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Solaar (Logitech MX Master 3S): start hidden in the tray so its messaging/
-- gesture rules stay active. Its Wayland key simulation needs write access to
-- /dev/uinput, otherwise rules silently do nothing.
-- o.launch_on_start("solaar --window=hide")

-- Logitech MX Master 3S is handled by Maestro (io.github.pughouselabs.maestro
-- plugin + maestrod user service), which owns the mouse's HID++ channel on its
-- own. Solaar is no longer started on login: running both makes them fight over
-- the device. Solaar's rules.yaml is kept in dotfiles for reference.
