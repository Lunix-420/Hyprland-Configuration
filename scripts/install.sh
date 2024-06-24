#!/usr/bin/env bash

# Define the base configuration folder
CONFIG_FOLDER="$HOME/.config/hypr"

# Log file
LOG_FILE="create_symlinks.log"

# Function for logging
log() {
	local datetime=$(date +'%Y-%m-%d %H:%M:%S')
	echo "[$datetime] $1" >>"$LOG_FILE"
}

# Function to check if a command is available
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

# Function to install required applications using pacman
install_apps() {
	local APPS=(package1 package2 package3) # List of packages to install

	for app in "${APPS[@]}"; do
		if ! command_exists "$app"; then
			log "Installing $app..."
			if ! sudo pacman -S --noconfirm "$app"; then
				log "Failed to install $app."
				echo "Failed to install $app. Aborting." >&2
				exit 1
			fi
			log "Installed $app successfully."
		else
			log "$app is already installed."
		fi
	done
}

# Function to create a symbolic link
link_file() {
	local TARGET="$1"
	local SOURCE="${CONFIG_FOLDER}${TARGET}"

	# Check if the target directory exists, create if it does not
	if [ ! -d "$(dirname "$TARGET")" ]; then
		if ! sudo mkdir -p "$(dirname "$TARGET")"; then
			log "Failed to create directory $(dirname "$TARGET")."
			echo "Failed to create directory $(dirname "$TARGET"). Aborting." >&2
			exit 1
		fi
		log "Created directory $(dirname "$TARGET")."
	fi

	# Create the symbolic link
	if ! sudo ln -sf "$SOURCE" "$TARGET"; then
		log "Failed to create symlink from $SOURCE to $TARGET."
		echo "Failed to create symlink from $SOURCE to $TARGET. Aborting." >&2
		exit 1
	fi

	log "Created symlink from $SOURCE to $TARGET."
}

# List of packages to install using pacman
PACKAGES_TO_INSTALL=(
	"sddm"
)

# List of target directories
LIST_OF_TARGETS=(
	"/usr/share/sddm/themes/catppuccin-macchiato"
	# Add more target directories here
	"/another/target/directory"
	"/yet/another/target/directory"
)

# Initialize log file
echo "Starting script execution at $(date)" >"$LOG_FILE"

# Install required packages using pacman before creating symlinks
for pkg in "${PACKAGES_TO_INSTALL[@]}"; do
	if ! command_exists "$pkg"; then
		install_apps
		break
	fi
done

# Loop through each target directory and create the symlink
for TARGET in "${LIST_OF_TARGETS[@]}"; do
	link_file "$TARGET"
done

log "Script execution completed."
echo "Script execution completed. See $LOG_FILE for details."
