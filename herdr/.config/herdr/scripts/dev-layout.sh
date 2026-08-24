#!/usr/bin/env bash
# dev-layout.sh — Recreates the tmux `ws` layout inside herdr:
#   nvim (left) | opencode (right, 20%) | terminal (bottom, 20%)
#
# Bound to prefix+d via [[keys.command]] in config.toml (type = "shell").
# Runs from the focused pane; herdr injects HERDR_ACTIVE_PANE_ID and
# HERDR_ACTIVE_PANE_CWD. New panes inherit the source pane's cwd
# (terminal.new_cwd = "follow"), so they land in the project you cd'd to.
set -euo pipefail

herdr="${HERDR_BIN_PATH:-herdr}"
pane="${HERDR_ACTIVE_PANE_ID:?not running inside a herdr pane}"

# 1. Split to the right for opencode (20% width)
right="$("$herdr" pane split --pane "$pane" --direction right --ratio 0.65 --no-focus \
  | jq -r '.result.pane.pane_id')"

# 2. Launch opencode in the new pane
"$herdr" pane run "$right" "opencode"

# 3. Split the original pane down for the terminal (20% height)
"$herdr" pane split --pane "$pane" --direction down --ratio 0.8 --no-focus

# 4. nvim in the original pane (top-left, keeps the focus)
"$herdr" pane run "$pane" "nvim ."
