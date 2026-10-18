-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Solaar (Logitech MX Master 3S): start hidden in the tray so its messaging/
-- gesture rules stay active. Its Wayland key simulation needs write access to
-- /dev/uinput, otherwise rules silently do nothing.
o.launch_on_start("solaar --window=hide")
