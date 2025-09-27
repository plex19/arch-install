#!/bin/bash

echo "=== Last System Update ==="

PACMAN_LOG="/var/log/pacman.log"

get_last_pacman_update() {
    if [ -f "$PACMAN_LOG" ]; then
        last_update=$(grep -a "starting full system upgrade" "$PACMAN_LOG" | tail -n 1 | cut -d']' -f1 | tr -d '[')
        if [ -n "$last_update" ]; then
            date -d "${last_update}" +"%Y-%m-%d %H:%M:%S"
        else
            echo "No Entry"
        fi
    else
        echo "No Pacman-Log"
    fi
}

last_repo_update=$(get_last_pacman_update)
echo "Pacman(repo): $last_repo_update"

if command -v yay &>/dev/null; then
    last_aur_update=$(find ~/.cache/yay -mindepth 1 -maxdepth 1 -type d -printf '%T@ %p\n' 2>/dev/null | sort -nr | head -n 1 | cut -d' ' -f1)
    if [ -n "$last_aur_update" ]; then
        last_aur_update_formatted=$(date -d @"$last_aur_update" +"%Y-%m-%d %H:%M:%S")
        echo "AUR(yay):   $last_aur_update_formatted"
    else
        echo "AUR (yay):   No AUR-Builds."
    fi
else
    echo "Yay: Not installed."
fi

