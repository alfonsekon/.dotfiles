#!/bin/bash

# CURRENT_PATH="$PWD"

selected=$(find ~/ ~/coding/android-studio/ ~/coding/vscode ~/school/third-year/second-sem ~/dotfiles -mindepth 1 -maxdepth 1 | fzf)

if [[ -z "$selected" ]]; then
    exit 0
fi

selected=$(realpath "$selected")

#old (will still keep incase)
# #replace current tab with selection
# wezterm cli spawn --cwd "$selected"
# sleep 1
# wezterm cli set-tab-title "$(basename "$selected")"

#new (testing)
wezterm cli set-tab-title "$(basename "$selected")"
cd "$selected"

if [[ "$selected" == *"android-studio/"* ]]; then
    echo "Opening in android-studio..."
    # android-studio "$selected" > /dev/null 2>&1 &
    android-studio "$selected" 
    i3 workspace 3
else
    echo "Opening in vscode..."
    code -n --reuse-window "$selected" 
    i3 workspace 3
fi

clear

#old
# wezterm cli kill-pane