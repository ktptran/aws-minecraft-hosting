#!/bin/bash
sudo su
mkdir MCServer
cd MCServer
wget https://launcher.mojang.com/v1/objects/a412fd69db1f81db3f511c1463fd304675244077/server.jar
sudo yum install java-1.8.0
y
java -Xmx1024M -Xms1024M -jar server.jar nogui
nano eula.txt # TODO: change to true eula=true for the third line
java -Xmx1024M -Xms1024M -jar server.jar nogui


key_name = 'python_automation_key'
key_path = key_name + '.pem'
key = ec2.create_key_pair(KeyName=key_name)
key.key_material
with open(key_path, 'w') as key_file:
    key_file.write(key.key_material)
os.chmod(key_path, stat.S_IRUSR | stat.S_IWUSR)
