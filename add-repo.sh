#!/bin/bash

function error() {
  echo -e "$(tput setaf 1)$(tput bold)$1$(tput sgr 0)"
}

#check that script is being run as root
if [ ! "$EUID" = 0 ]; then
    error "The script wasn't run as root!"
    echo "$(tput bold)you NEED to run this script as root!$(tput sgr 0)"
    exit 1
fi

echo -e "$(tput setaf 6)adding repo...$(tput sgr 0)"
echo ' + sudo wget https://raw.githubusercontent.com/Itai-Nelken/electron-discord-webapp_debian-repo/main/discord-webapp.list -O /etc/apt/sources.list.d/discord-webapp.list'
sudo wget https://raw.githubusercontent.com/Itai-Nelken/electron-discord-webapp_debian-repo/main/discord-webapp.list -O /etc/apt/sources.list.d/discord-webapp.list || error "Failed to download 'discord-webapp.list'!"; exit 1
echo "adding key..."
echo ' + wget -qO- https://raw.githubusercontent.com/Itai-Nelken/electron-discord-webapp_debian-repo/main/KEY.gpg | sudo apt-key add -'
wget -qO- https://raw.githubusercontent.com/Itai-Nelken/electron-discord-webapp_debian-repo/main/KEY.gpg | sudo apt-key add - || error "Failed to download and add key!"; exit 1
echo -e "$(tput setaf 6)running apt update...$(tput sgr 0)"
echo " + sudo apt update"
sudo apt update || error "Failed to run 'sudo apt update'! please run that"; true; sleep 3
echo -e "$(tput setaf 2)DONE!$(tput sgr 0)"
echo -e "$(tput setaf 6)$(tput bold)To install electron-discord-webapp, run:$(tput sgr 0)"
echo -e "$(tput bold)sudo apt install electron-discord-webapp$(tput sgr 0)"
