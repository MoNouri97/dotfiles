---
name: memomeister-sim
description: Run MemoMeister (auvilain) use cases on the iOS Simulator — login, upload, navigation checks — when the user asks for a simulator test or flow. Builds/launches the app, drives it with AXe, verifies with screenshots. Load together with the `axe` skill.
---

# MemoMeister on iOS Simulator

Only run when the user asks for a simulator test/flow. Within that task, boot,
launch, tap, type and screenshot in the simulator without asking each step.
Don't touch other macOS apps.

## Facts

- Repo: `~/Dev/mobile-repo/<worktree>` (use the current working dir).
- Bundle id: `xyz.freiraum.auvilain2`. URL scheme: `memomeister://`.
- Login: OAuth via `react-native-app-auth` → iOS shows a system alert
  ("… Wants to Use … to Sign In" → tap `Continue`), then a web login sheet.
- Any login prompt (login screen, "Your session has expired" modal, web
  login form): stop and ask the user for credentials before tapping anything.
  Don't rely on saved cookies or env vars. Never tap `LOGOUT` unless asked.
- Tab bar labels: `Dashboard`, `Notifications`, `Folders`, `Upload`,
  `Settings` (`axe tap --label`). Error toasts can cover the tab bar; close
  via their X first.
- `describe-ui` may error right after launch ("No translation object") —
  wait a few seconds / take a screenshot instead, then retry.
- Metro may be running from another worktree: check
  `lsof -p <metro pid> -a -d cwd` and tell the user which code is served.
- Text input: sim has an AZERTY keyboard enabled, so `axe type` garbles text
  (a→q, drops `-`). Instead: focus field, clear with
  `axe key-sequence --keycodes 42,42,…`, then
  `printf '<text>' | xcrun simctl pbcopy <UDID>` and
  `axe key-combo --modifiers 227 --key 25` (Cmd+V). Verify via `AXValue`.
- Test sandbox: Dashboard → Favorite Folders → `Mohamed Testing` →
  `claude-testing`. Create/upload test data only there. `Mohamed Testing`
  label appears twice on Dashboard → tap by coordinates.
- Create folder: inside a folder, orange `+` FAB → Create new `Folder` →
  `Create folder (without project template)` → name → folder+ icon top right.
  Folder ⋮ menu has Delete — never use unless asked.
- Few `testID`s exist; target elements by visible label from `describe-ui`.
  App strings are i18n (`translations/{de,en}.json`) — check the simulator language.
- Credentials: only from the user in chat. Use them for the current session
  only; never write them to files, logs or memory.

## Setup

1. Pick device: `axe list-simulators`; prefer a booted one, else an iPhone
   17 / 16 (Shutdown) and `xcrun simctl boot <UDID> && open -a Simulator`.
2. App installed? `xcrun simctl get_app_container <UDID> xyz.freiraum.auvilain2`.
   If not, or the user wants the current branch: ensure Metro is running
   (`yarn start` in background; codegen runs as part of it), then
   `yarn ios --udid <UDID>` (slow first build). Don't run `yarn clean`.
3. Launch: `xcrun simctl launch <UDID> xyz.freiraum.auvilain2`
   (`terminate` first for a fresh start).

## Use cases

- **Login**: launch → `describe-ui` → tap login button (label from
  `general.login`) → `Continue` on system alert → fill email/password in web
  sheet (`axe tap` field, `axe type --stdin`) → submit → verify home screen
  via `describe-ui`/screenshot. Grant notification prompt if shown.
- **Upload**: seed media first with
  `xcrun simctl addmedia <UDID> <file.jpg|.pdf|.mp4>`, then navigate to the
  upload entry point, pick the item, confirm, and verify the upload queue /
  toast finishes (poll `describe-ui`, don't sleep blindly).
- **Permissions**: preset with `xcrun simctl privacy <UDID> grant
  photos|camera|microphone xyz.freiraum.auvilain2` to skip prompts when the
  flow isn't about them.
- **Font size / Dynamic Type**: `xcrun simctl ui <UDID> content_size
  accessibility-extra-extra-extra-large` (default `large`). Changing it
  live leaves already-mounted screens with fragmented/clipped text — always
  terminate + relaunch the app after changing size, before judging layout.
  Reset to `large` and relaunch when done. Also: `ui <UDID> appearance dark`.
- **Deep link**: `xcrun simctl openurl <UDID> 'memomeister://…'`.
- **Logs**: `xcrun simctl spawn <UDID> log stream --predicate
  'process == "auvilain"' --style compact` (background, time-boxed); Metro
  output for JS errors.

## Rules

- Prefer `axe batch` with `--wait-timeout` for multi-step sequences; inspect
  with `describe-ui` between screens when labels are unknown.
- Verify each milestone with `describe-ui` or a screenshot to
  `$TMPDIR/sim-*.png` and read it.
- Report: steps run, pass/fail per milestone, screenshot paths, any red
  box / error toast text.
