#!/bin/bash
JENKINS_HOME=/opt/jenkins/master
JENKINS_DIR=/opt/jenkins/bin   #(<- .war here)
sudo yum install -y epel-release 

sudo yum install -y git nginxvim net-tools mc nano unzip wget nano firewalld httpd-tools



sudo yum install -y java-1.8.0-openjdk
echo "java has been installed"
java -version

cd /opt
sudo mkdir /opt/jenkins
sudo mkdir $JENKINS_HOME
sudo mkdir $JENKINS_DIR
cd $JENKINS_DIR

echo "directory for jenkins has been just created"


sudo wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
sudo chown -R vagrant:vagrant /opt/jenkins


echo "jenkins.war has been downloaded"


echo "# Systemd unit file for jenkins
[Unit]
Description=Jenkins Service
After=syslog.target network.target
[Service]

ExecStart=/usr/bin/java -Xms1500M -Xmx3000M -jar $JENKINS_DIR/jenkins.war
Environment='JAVA_OPTS=-Djenkins.install.runSetupWizard=false -Djava.awt.headless=true'
User=vagrant
Restart=always

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/jenkins.service


sudo yum install -y nginx
echo "nginx has been installed"
sudo sed -i "/^[^#].*server {/i $(printf '%.0s\ ' {0..3})upstream jenkins {\n\tserver 127.0.0.1:8080;\n    }" /etc/nginx/nginx.conf
sudo sed -i '/^[^#].*location \//a \\tproxy_pass http://jenkins;' /etc/nginx/nginx.conf
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl enable nginx
sudo systemctl start jenkins
sudo systemctl start nginx
echo "nginx started"
echo "jenkins started"

