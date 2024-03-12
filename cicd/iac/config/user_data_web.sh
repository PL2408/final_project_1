#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update Route53 record with new public IP
aws s3 cp s3://lopihara/config/update_route53.json /opt/
aws s3 cp s3://lopihara/config/update_route53.sh /opt/
chmod +x /opt/update_route53.sh
sed -i 's/HOSTNAME/web/g' /opt/update_route53.json

yum install docker git htop dos2unix -y
dos2unix /opt/update_route53.sh

# Create crontab job to update record on restart
cronjob="@reboot /opt/update_route53.sh"
cat <(echo "$cronjob") | crontab -

yum update -y

# installation docker
systemctl enable docker.service

# create user web
useradd -m -d /home/web -s /bin/bash web

# add agent to group docker
usermod -a -G docker web

mkdir -p /home/web/.ssh

# use (ssh-keygen -b 4096 -t rsa) command for generating key pairs
# add web pb_k
aws s3 cp s3://lopihara/ssh_keys/web4k.pub /home/web/.ssh/web4k.pub
mv /home/web/.ssh/web4k.pub /home/web/.ssh/authorized_keys

# set owner for .ssh/
chown -R web:web /home/web/.ssh

# set permissions to .ssh/ folder and authorized_keys file
chmod 700 /home/web/.ssh
chmod 600 /home/web/.ssh/authorized_keys

# create html/ folder, set owner and permission
mkdir /home/web/html
chown -R web:web /home/web/html
chmod 755 /home/web/html

# start docker
systemctl start docker

# start nginx
docker run -d -it --rm --name devopsik-page -p 80:80 lopihara/devopsik-page:latest

# custom PS1
aws s3 cp s3://lopihara/config/web_server_ps1.sh /etc/ps1.sh
dos2unix /etc/ps1.sh
echo "" >> /etc/bashrc
echo "source /etc/ps1.sh" >> /etc/bashrc