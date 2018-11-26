#!/bin/bash

#install java 8
sudo yum install -y java-1.8.0-openjdk
java -version

#install jenkins
sudo wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
mkdir /opt/jenkins
mv /home/vagrant/jenkins.war /opt/jenkins
sudo chown -R vagrant:vagrant /opt/jenkins

#Systemd  File
sudo touch /etc/systemd/system/jenkins.service
sudo cat > /etc/systemd/system/jenkins.service <<EOF
[Unit]
Description=Jenkins Daemon
After=network.target
[Service]
ExecStart=/usr/bin/java -Xms1500M -Xmx3000M -jar /opt/jenkins/jenkins.war
User=vagrant
Restart=always
[Install]
WantedBy=multi-user.target
EOF

#install nginx
sudo yum install -y epel-release
sudo yum install -y nginx
sudo sed -i '/^[^#].*location \/ {/a  proxy_pass    http://192.168.115.60:8080;' /etc/nginx/nginx.conf
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl enable nginx
sudo systemctl start jenkins
sudo systemctl start nginx
