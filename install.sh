#!/bin/sh

clear
echo "Project Number : Project 003"
sleep 0.2
echo "Type : Installer"
sleep 0.2
echo "Build Date : 11-17-21"
sleep 0.2
echo "Author : JyanJohn"
sleep 0.2
echo "Version : 1.2"
echo ""

sleep 3
echo "Preparing for Installation..."
sleep 2
echo "Done!"

apt update
apt upgrade -y

apt-get install git -y
apt-get install curl -y
apt-get install php -y
apt-get install wget -y
apt-get install toilet -y

apt-get install python3 -y
apt-get install ruby -y

apt-get install nmap -y

clear
echo "To use the Bruter, just type './main.sh'"
echo "<^> J Y A N J O H N <^>"
sleep 3
echo ""

echo "Installing Gems and Cleanup"
apt autoremove
exec gem install lolcat
