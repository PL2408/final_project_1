#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

yum update -y
yum install java git -y

# setup jenkins repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# download jenkins
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo


# swap file for ec2 (5GB)
echo "------------------ Create SWAP File ----------------"
swapoff -a
dd if=/dev/zero of=/swapfile bs=128M count=40
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
echo "------------------ SWAP File Created ----------------"


# install jenkins
yum install jenkins -y
# enable auto start
systemctl enable jenkins
# start jenkins
systemctl start jenkins

# custom PS1
# shellcheck disable=SC2016
printf 'export PS1="\[\e[0;38;5;38m\]\u\[\e[0m\]\[\e[0m\]@\[\e[0m\]\[\e[0;38;5;223m\]jenkins_server\[\e[0m\][\[\e[0m\]\w\[\e[0m\]]\[\e[0m\]<\[\e[0m\]\$?\[$(tput sgr0)\]\[\e[0m\]>\[\e[0m\]:\[\e[0m\] "' >> /etc/bashrc