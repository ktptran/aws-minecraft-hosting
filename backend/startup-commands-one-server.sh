#!/bin/bash

# Move to root privileges
sudo su

# Upgrade the machine
sudo yum update -y

# Install java 8
sudo yum install -y java-1.8.0

# Install nodeJS and repositories
sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
sudo apt-get -y install nodejs

# Install dependencies
sudo apt-get install git supervisor rdiff-backup screen build-essential openjdk-7-jre-headless

# Install MineOS
sudo mkdir -p /usr/games
sudo cd /usr/games
sudo git clone https://github.com/hexparrot/mineos-node.git minecraft
sudo cd minecraft

# Configure git package
sudo git config core.filemode false # change config
sudo chmod +x service.js mineos_console.js generate-sslcert.sh webui.js # set js files to be executable
sudo npm install # install NodeJS

# Creates symlink to executable and copies config file into directory
sudo ln -s /usr/games/minecraft/mineos_console.js /usr/local/bin/mineos
sudo cp mineos.conf /etc/mineos.conf

# SSL Certificate
sudo cd /usr/games/minecraft
sudo ./generate-sslcert.sh

# Start MineOS Server
sudo supervisorctl start mineos


# Get minecraft server
mkdir MCServer
cd MCServer
wget https://launcher.mojang.com/v1/objects/a412fd69db1f81db3f511c1463fd304675244077/server.jar

# Launch server
java -Xmx1024M -Xms1024M -jar server.jar nogui
sed -i 's/eula=false/eula=true/g' eula.txt
java -Xmx1024M -Xms1024M -jar server.jar nogui
