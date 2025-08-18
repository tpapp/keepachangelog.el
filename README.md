# keepachangelog: Simplifies keeping a CHANGELOG.md

<!-- [![MELPA](https://melpa.org/packages/julia-repl-badge.svg)](https://melpa.org/#/keepachangelog) -->

Simplifies keeping a `CHANGELOG.md` in Emacs, following the guidelines at [keepachangelog.com](https://keepachangelog.com/).

## Functionality

`changelog-open` (<kbd>C-c C-l C-o</kbd>) opens the `CHANGELOG.md` in the closest parent directory to the current buffer. This is the only global binding, the other two are buffer-local, setup only for `CHANGELOG.md` using a hook.

`changelog-insert-header` inserts a header at the top (`# Changelog ...`).

`changelog-insert-unreleased` (<kbd>C-c C-e C-u</kbd>) inserts an `## [Unreleased]` heading at the point, with all relevant subheadings. You should then add items manually, and remove unused subheadings upon release.

<kbd>C-c C-e C-a</kbd> is bound to a combination of `changelog-insert-header` and `changelog-insert-unreleased`.
