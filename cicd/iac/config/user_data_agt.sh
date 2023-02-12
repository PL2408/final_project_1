#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

yum update -y
yum install java git -y

useradd -m -d /home/agent -s /bin/bash agent
mkdir /home/agent/jenkins
chown agent:agent /home/agent/jenkins

mkdir /home/agent/.ssh
chmod 700 /home/agent/.ssh

aws s3 cp s3://lopihara/ssh_keys/web.pk /home/agent/.ssh/web.pk
aws s3 cp s3://lopihara/ssh_keys/agent.pb /home/agent/.ssh/agent.pb
mv /home/agent/.ssh/agent.pb /home/agent/.ssh/authorized_keys

chmod 400 /home/agent/.ssh/web.pk
chmod 600 /home/agent/.ssh/authorized_keys

chown -R agent:agent /home/agent/.ssh

printf 'export PS1="\[\e[0;38;5;38m\]\u\[\e[0m\]\[\e[0m\]@\[\e[0m\]\[\e[0;38;5;229m\]jenkins_agent\[\e[0m\][\[\e[0m\]\w\[\e[0m\]]\[\e[0m\]<\[\e[0m\]\$?\[$(tput sgr0)\]\[\e[0m\]>\[\e[0m\]:\[\e[0m\] "' >> /etc/bashrc
