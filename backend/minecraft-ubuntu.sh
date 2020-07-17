# Allow commands through lightsail
sudo apt -y update && sudo apt -y install default-jre screen

# screen will keep running Minecraft after we disconnect SSH
screen

# Make sure to click enter here before entering in next commands

# Create a directory to hold the Minecraft files:
sudo mkdir MCServer
cd MCServer

sudo wget https://launcher.mojang.com/v1/objects/a412fd69db1f81db3f511c1463fd304675244077/server.jar

sudo java -Xmx1G -Xms1G -jar server.jar nogui

sudo chown ubuntu eula.txt
echo "eula=true" > eula.txt

sudo java -Xmx1G -Xms1G -jar server.jar nogui
