#!/usr/bin/env bash

set -euo pipefail # Enable some useful options for bash scripting

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER_DIR="${SCRIPT_DIR}/../"

#==================================================================================================
# Install yay
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
sudo pacman -S dkms nvidia-dkms nvidia-utils lib32-nvidia-utils egl-wayland --noconfirm

#==================================================================================================
# Configuring

# Copy files from "$INSTALLER_DIR/external" to "/"
echo "Copying files to root directory..."
sudo cp -r "${INSTALLER_DIR}/external/"* "/"

echo "Configuring GRUB..."
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "Creating modified initial ramdisk..."
sudo mkinitcpio -P

# Copy entire installer directory to ~/.config/hypr
echo "Copying installer directory to ~/.config/hypr..."
mkdir -p "$HOME/.config/hypr"
cp -r "${INSTALLER_DIR}/"* "$HOME/.config/hypr/"

#==================================================================================================
# Applications

echo "Installation complete."
