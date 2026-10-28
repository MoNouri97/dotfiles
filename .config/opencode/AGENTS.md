# Global rules

## Always ask before touching the live desktop

- Anything that changes the live desktop UI requires my explicit agreement
  first — every time, not just when I seem busy. This includes opening or
  closing menus/launchers, launching apps, changing focus or workspaces,
  typing with `wtype`/`ydotool`/`xdotool`, reloading the shell, and taking
  screenshots.
- Before doing any of that, say what you want to do, why, and what it will
  visibly change, then wait for my yes. Do not act on an assumed or implied
  yes, and ask again for each new action.
- Prefer static investigation first: read the config, read the read-only
  Omarchy source under `/usr/share/omarchy/`, validate parsing with a script,
  check symlinks, `git status`, `hyprctl binds`.
- If only a live check can answer the question, give me the exact steps and
  wait for my result instead of doing it yourself.
- Never rewrite a file I may have open in an editor without asking. If a
  temporary edit is unavoidable: back it up, restore it, verify it is
  byte-identical, and tell me what changed.

Reason: this rule exists because an agent opened the Omarchy menu, typed into
its search field, and rewrote a file that was open in Neovim while I was
actively using the machine.
