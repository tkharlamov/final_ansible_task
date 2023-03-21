#!/bin/bash
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'; sleep 10
sudo apt update
sudo apt install -y openjdk-17-jre-headless
sudo apt install -y jenkins
sudo systemctl start jenkins
#sudo systemctl status jenkins && exit 0
