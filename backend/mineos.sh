#!/bin/bash

# Move to root privileges
sudo su

# Upgrade the machine
sudo yum update -y

# Install java 8
sudo yum install -y java-1.8.0

# Get minecraft server
mkdir MCServer
cd MCServer
wget https://launcher.mojang.com/v1/objects/a412fd69db1f81db3f511c1463fd304675244077/server.jar

# Launch server
java -Xmx1024M -Xms1024M -jar server.jar nogui
sed -i 's/eula=false/eula=true/g' eula.txt
java -Xmx1024M -Xms1024M -jar server.jar nogui
