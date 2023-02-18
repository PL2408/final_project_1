#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

#############################################
# Install software
#############################################
yum update -y
yum install java git docker -y

systemctl enable docker.service
service docker start

#############################################
# Create user 'agent'
#############################################
useradd -m -d /home/agent -s /bin/bash agent
# add agent to group docker
usermod -a -G docker agent
# create home directory for agent
mkdir /home/agent/jenkins
chown agent:agent /home/agent/jenkins

# init .ssh authentication
mkdir /home/agent/.ssh
chmod 700 /home/agent/.ssh

aws s3 cp s3://lopihara/ssh_keys/web.pk /home/agent/.ssh/web.pk
aws s3 cp s3://lopihara/ssh_keys/agent.pb /home/agent/.ssh/agent.pb
mv /home/agent/.ssh/agent.pb /home/agent/.ssh/authorized_keys

chmod 400 /home/agent/.ssh/web.pk
chmod 600 /home/agent/.ssh/authorized_keys

chown -R agent:agent /home/agent/.ssh

# custom PS1
aws s3 cp s3://lopihara/config/jenkins_agent_ps1.sh /etc/ps1.sh
echo "" >> /etc/bashrc
echo "source /etc/ps1.sh" >> /etc/bashrc
