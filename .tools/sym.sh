#!/usr/bin/env bash
set -e

mkdir -p ~/.config
stow -d ~/Workspace/dotfiles -t ~/.config .config
mkdir -p ~/.tools
stow -d ~/Workspace/dotfiles -t ~/.tools .tools

# sudo rm -r /usr/share/rofi/themes
mkdir -p ~/.local/share/rofi/themes
stow -d ~/Workspace/dotfiles/.tools/themes -t ~/.local/share/rofi/themes rofi


