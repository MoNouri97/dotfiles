---
description: New patch tag, push it, Codemagic build (ios|android|apk|all)
---

Targets: `$ARGUMENTS`

Branch: !`git branch --show-current`
Status: !`git status -sb | head -1`
HEAD: !`git log -1 --format='%h %s %D'`
Latest tags: !`git tag --sort=-v:refname -l 'v*.*.*' | head -3`

1. Targets must be one or more of `ios`, `android`, `apk`, `all`. Empty or invalid: ask, stop.
2. Stop and report if working tree dirty or HEAD already has a `v*.*.*` tag.
3. Next tag = highest tag above with patch + 1. Message: one short line summarizing commits since that tag.
4. `git tag -a <tag> -m "<msg>"`, then `git push origin <tag>`. Push only the tag; if branch is ahead of origin, mention it, don't push it.
5. Run `zsh -ic 'cmbuild <tag> <targets>'` (`cmbuild` is an alias; `CM_API_TOKEN` only loads in interactive zsh). Ignore `zle` warnings. With multiple targets, always put `ios` first so the iOS build is triggered first (`cmbuild` triggers in argument order).
6. Report tag, commit, and build URLs.
