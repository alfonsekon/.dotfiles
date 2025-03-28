#!/bin/bash

# this script is used by wezterm/.config/wezterm/keybinds.lua 
# this script opens a fuzzy finder in my common working directories and recent zoxide queries
# and opens neovim and another wezterm tab within that directory

# NOTE:
# only call/execute sessionizers within a bash session.
# this will not behave as expected when inside vim or other TUI applications

selected=$(find $(pwd) $(zoxide query -l) ~/ ~/coding/android-studio/ ~/coding/vscode ~/school/third-year/second-sem ~/dotfiles -mindepth 1 -maxdepth 1 | fzf)

if [[ -z "$selected" ]]; then
    exit 0
fi

selected=$(realpath "$selected")

if [[ -d "$selected" ]]; then
    tab_id=$(wezterm cli spawn --cwd "$selected")
    wezterm cli set-tab-title --pane-id "$tab_id" "$(basename "$selected")"

    sleep 0.1

    nvim "$selected"
else
    dir_name=$(dirname "$selected")

    tab_id=$(wezterm cli spawn --cwd "$dir_name")
    wezterm cli set-tab-title --pane-id "$tab_id" "$(basename "$dir_name")"
    nvim "$selected"
fi
