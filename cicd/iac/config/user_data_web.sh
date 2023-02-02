#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

yum update -y

# installation docker
yum install docker git htop -y

# create user web
useradd -m -d /home/web -s /bin/bash web
mkdir -p /home/web/.ssh

# add web pb_k
aws s3 cp s3://lopihara/ssh_keys/web.pb /home/web/.ssh/web.pb
mv /home/web/.ssh/web.pb /home/web/.ssh/authorized_keys

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
docker run -p 80:80 -v /home/web/html:/usr/share/nginx/html:ro -d nginx


# custom PS1
printf 'export PS1="\[\e[0;38;5;39m\]ec2-user\[\e[0m\]@\[\e[0m\]\[\e[0;38;5;49m\]web-server\[\e[0m\][\[\e[0m\]\w\[\e[0m\]]\[\e[0m\]<\[\e[0m\]\$?\[$(tput sgr0)\]\[\e[0m\]>\[\e[0m\]:\[\e[0m\] "' >> /etc/bashrc




