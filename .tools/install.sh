#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPS_FILE="$SCRIPT_DIR/deps"

# Function to install deps
install_deps() {
    if [[ ! -f "$DEPS_FILE" ]]; then
        echo "No deps file found, skipping dependency install"
        return
    fi

    echo "Installing dependencies from deps file..."

    if command -v yay >/dev/null 2>&1; then
        INSTALLER="yay -S --needed --noconfirm"
    else
        INSTALLER="sudo pacman -S --needed --noconfirm"
    fi

    while IFS= read -r pkg || [[ -n "$pkg" ]]; do
        [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
        $INSTALLER "$pkg"
    done < "$DEPS_FILE"
}

# If yay already exists, just install deps and exit
if command -v yay >/dev/null 2>&1; then
    echo "yay is already installed ✅"
    yay --version
    install_deps
    exit 0
fi

echo "yay not found. Installing..."

# Base build deps (pacman only)
sudo pacman -S --needed --noconfirm git base-devel

# Create temp directory
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

# Clone yay repo
git clone https://aur.archlinux.org/yay.git
cd yay

# Build and install yay
makepkg -si --noconfirm

# Cleanup
cd /
rm -rf "$TMP_DIR"

echo "yay installed successfully 🎉"
yay --version

# Install deps now that yay exists
install_deps
yay -Sy brave-bin

$HOME/Workspace/dotfiles/.tools/sym.sh
