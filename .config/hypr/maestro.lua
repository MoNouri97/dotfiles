-- Maestro settings window: centered floating window of a deliberate size.
o.window({ class = "^(org\\.quickshell)$", title = "^(Maestro)$" }, {
  float = true,
  center = true,
  size = { 1280, 820 },
  min_size = { 1000, 680 },
})
