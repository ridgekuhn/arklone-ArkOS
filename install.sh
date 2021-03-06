#!/bin/bash
# arklone installation script
# by ridgek
########
# CONFIG
########
source "/opt/arklone/config.sh"

##############
# DEPENDENCIES
##############
# Install rclone
if ! rclone --version &> /dev/null; then
	sudo apt update && sudo apt install rclone -y || (echo "Could not install required dependencies" && exit 1)
fi

# Create user-accessible rclone dir on EASYROMS
if [ ! -d "/roms/backup/rclone" ]; then
	sudo mkdir "/roms/backup/rclone"
fi

# Create user-accessible rclone.conf on EASYROMS
if [ ! -f "/roms/backup/rclone/rclone.conf" ]; then
	sudo touch "/roms/backup/rclone/rclone.conf"
fi

# Create rclone user config dir
if [ ! -d "${USER_CONFIG_DIR}/rclone" ]; then
	sudo mkdir "${USER_CONFIG_DIR}/rclone"
fi
sudo chown -R ark:ark "${USER_CONFIG_DIR}/rclone"
sudo chmod -R 777 "${USER_CONFIG_DIR}/rclone"

# Link user-accessible rclone.conf so rclone can find it
sudo ln -v -s "/roms/backup/rclone/rclone.conf" "${USER_CONFIG_DIR}/rclone/rclone.conf"

#########
# arklone
#########
# Grant permissions to scripts
sudo chmod -v a+r+x "${ARKLONE_DIR}/uninstall.sh"
sudo chmod -v a+r+x "${ARKLONE_DIR}/dialogs/settings.sh"
sudo chmod -v a+r+x "${ARKLONE_DIR}/rclone/scripts/arklone-saves.sh"
sudo chmod -v a+r+x "${ARKLONE_DIR}/rclone/scripts/arklone-arkos.sh"
sudo chmod -v a+r+x "${ARKLONE_DIR}/systemd/scripts/generate-retroarch-units.sh"

# Create user-accessible rclone dir on EASYROMS
if [ ! -d "/roms/backup/arklone" ]; then
	sudo mkdir "/roms/backup/arklone"
fi

# Create arklone user config dir
if [ ! -d "${USER_CONFIG_DIR}/arklone" ]; then
	sudo mkdir "${USER_CONFIG_DIR}/arklone"
fi
sudo chown -R ark:ark "${USER_CONFIG_DIR}/arklone"
sudo chmod -R a+r+w "${USER_CONFIG_DIR}/arklone"
