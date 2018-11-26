sudo yum install java nginx -y
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-0.el7_5.x86_64/" | sudo tee -a ~/.bash_profile
echo "export JRE_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-0.el7_5.x86_64/jre" | sudo tee -a ~/.bash_profile
source ~/.bashrc
wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war
#cp /vagrant/jenkins.war /home/vagrant/
#sudo chown vagrant:vagrant jenkins.war
sudo sed -i "/^[^#].*server {/i $(printf '%.0s\ ' {0..3})upstream jenkins {\n\tserver 127.0.0.1:8080;\n    }" /etc/nginx/nginx.conf
#sed -i '/^[^#].*server {/ a \\tlocation \/jenkins {\n\t\tproxy_pass http://localhost:8080;}' /etc/nginx/nginx.conf
sudo sed -i '/^[^#].*location \//a \\tproxy_pass http://jenkins;' /etc/nginx/nginx.conf
printf "[Unit]\n" | sudo tee /etc/systemd/system/jenkins.service
printf "Description=Jenkins Daemon\n" | sudo tee -a /etc/systemd/system/jenkins.service
printf "[Service]\n" | sudo tee -a /etc/systemd/system/jenkins.service
printf "ExecStart=/usr/bin/java -jar /home/vagrant/jenkins.war\n" | sudo tee -a /etc/systemd/system/jenkins.service
printf "User=vagrant\n" | sudo tee -a /etc/systemd/system/jenkins.service
printf "[Install]\n" | sudo tee -a /etc/systemd/system/jenkins.service
printf "WantedBy=multi-user.target\n" | sudo tee -a /etc/systemd/system/jenkins.service
sudo systemctl start nginx
sudo systemctl start jenkins