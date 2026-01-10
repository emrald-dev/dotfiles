#!/bin/bash 

# Shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# programs
sudo pacman -S --needed git base-devel swww zsh rofi waybar swaync xdg-user-dirs nwg-look adw-gtk-theme stow

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd "$HOME"
echo "$(pwd)"

# fonts
yay -S --needed ttf-jetbrains-mono-nerd ttf-geist-mono-nerd papirus-icon-theme papirus-folders apple_cursor

# Create User Folders (Desktop, Documents, Downloads, Videos, Music etc)
xdg-user-dirs update

# Symlink all necessary files
config="./config.json"

