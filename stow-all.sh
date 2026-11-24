#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v stow >/dev/null 2>&1; then
    echo "GNU Stow is not installed. Install it first with:" >&2
    echo "  sudo pacman -S stow" >&2
    exit 1
fi

PACKAGES=(
    btop
    fuzzel
    git
    gtk
    hypr
    kitty
    mako
    mpv
    neofetch
    scripts
    waybar
    xdg
    zsh
)

cd "$SCRIPT_DIR"
stow --no-folding --target="$HOME" --restow "${PACKAGES[@]}"
echo "Stowed ${#PACKAGES[@]} packages into $HOME"
