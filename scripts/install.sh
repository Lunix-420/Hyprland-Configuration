#!/usr/bin/env bash

set -euo pipefail # Enable some useful options for bash scripting

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
INSTALLER_DIR="${SCRIPT_DIR}/../"

# Postpone mkinitcpio call to the end of the script
REBUILD_INITRAMFS=false

sudo pacman -Syu --noconfirm
sudo pacman -S --needed base-devel

#==================================================================================================
# Install yay
#
echo "Installing yay..."
if ! command -v yay &>/dev/null; then
	# Check if git and base-devel are installed
	if ! command -v git &>/dev/null || ! command -v makepkg &>/dev/null; then
		echo "Installing git and base-devel..."
		sudo pacman -S --needed git base-devel --noconfirm
	fi

	# Clone yay repository from AUR
	echo "Cloning yay from AUR..."
	git clone https://aur.archlinux.org/yay.git /tmp/yay

	# Navigate into yay directory
	pushd /tmp/yay >/dev/null

	# Build and install yay
	echo "Building and installing yay..."
	makepkg -si --noconfirm

	# Clean up
	echo "Cleaning up..."
	popd >/dev/null
	rm -rf /tmp/yay

	echo "yay installation completed."
else
	echo "yay is already installed."
fi

#==================================================================================================
# Install fonts
echo "Installing fonts..."
sudo pacman -S otf-comicshanns-nerd --noconfirm
yay -S ttf-comic-sans --noconfirm

#==================================================================================================
# Install core packages
echo "Installing core packages..."
sudo pacman -S hyprland sddm plymouth --noconfirm

#==================================================================================================
# Install NVIDIA drivers
echo "Installing NVIDIA drivers..."
sudo pacman -S linux nvidia nvidia-utils lib32-nvidia-utils egl-wayland --noconfirm

#==================================================================================================
# Configuring

# Copy files from "$INSTALLER_DIR/external" to "/"
echo "Copying files to root directory..."
sudo cp -r "${INSTALLER_DIR}/external/"* "/"

echo "Configuring GRUB..."
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Set splash screen in the background
{
	echo "Setting splash screen..."
	sudo plymouth-set-default-theme -R lunix
} &

# Copy entire installer directory to ~/.config/hypr
echo "Copying installer directory to ~/.config/hypr..."
mkdir -p "$HOME/.config/hypr"
cp -r "${INSTALLER_DIR}/"* "$HOME/.config/hypr/"

#==================================================================================================
# Applications

echo "Installing important applications..."
sudo pacman -S alacritty fuzzel waybar --noconfirm
yay -S hyprpicker hyprshot hyprshade waypaper-engine-git --noconfirm

echo "Installing Lazyvim..."
sudo pacman -S ripgrep fd lazygit clang neovim --noconfirm

echo "Installing Qt Apps..."
sudo pacman -S qt5ct qt6ct kvantum dolphin yazi ark kate --noconfirm

echo "Installing Media Apps..."
sudo pacman -S firefox keepassxc font-manager --noconfirm
yay -S armcord-git spotify spicetify --noconfirm

# Install oh-my-posh in the background
{
	echo "Installing oh-my-posh..."
	curl -s https://ohmyposh.dev/install.sh | bash -s
} &

# Copy dotfiles
echo "Copying dotfiles..."
cp -r "${INSTALLER_DIR}/dotfiles/"* "$HOME/"
cp -r "${INSTALLER_DIR}/dotfiles/."* "$HOME/"

# Rebuild initial ramdisk at the end
REBUILD_INITRAMFS=true

echo "Installation complete."

if [ "$REBUILD_INITRAMFS" = true ]; then
	echo "Creating modified initial ramdisk..."
	sudo mkinitcpio -P
fi

# Wait for background processes to complete
echo "Waiting for background processes to complete"
wait

echo "All tasks completed."
