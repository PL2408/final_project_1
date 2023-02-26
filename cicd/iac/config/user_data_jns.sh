#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update Route53 record with new public IP
aws s3 cp s3://lopihara/config/update_route53.json /opt/
aws s3 cp s3://lopihara/config/update_route53.sh /opt/
chmod +x /opt/update_route53.sh
sed -i 's/HOSTNAME/jenkins/g' /opt/update_route53.json
/opt/update_route53.sh

# Create crontab job to update record on restart
cronjob="@reboot /opt/update_route53.sh"
cat <(echo "$cronjob") | crontab -

yum update -y
yum install java git docker dos2unix -y

# Update Route53 record with new public IP
aws s3 cp s3://lopihara/config/update_route53.json /opt/
aws s3 cp s3://lopihara/config/update_route53.sh /opt/
chmod +x /opt/update_route53.sh
sed -i 's/HOSTNAME/jenkins/g' /opt/update_route53.json
/opt/update_route53.sh

# Create crontab job to update record on restart
cronjob="@reboot /opt/update_route53.sh"
cat <(echo "$cronjob") | crontab -

# swap file for ec2 (3GB)
echo "------------------ Create SWAP File ----------------"
swapoff -a
dd if=/dev/zero of=/swapfile bs=128M count=24
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
echo "------------------ SWAP File Created ----------------"

systemctl enable docker
service docker start

######################################
#        Run Jenkins
######################################
# jenkins docker volume location /var/lib/docker/volumes/jenkins_home
docker volume create jenkins_home

# Copy files from S3 to jenkins volume
#res=`aws s3 ls s3://lopihara/backup/ | awk '{print $2}' | sort | tail -n 1`
#if [ -n "$res" ]; then
#  aws s3 cp s3://lopihara/backup/$res /var/lib/docker/volumes/jenkins_home --recursive
#fi

#DATE=`date +%Y-%m-%d-%H%M`
#SOURCE=/var/lib/docker/volumes/jenkins_home
#DEST=lopihara/backup/$DATE
#aws s3 cp $SOURCE s3://$DEST --recursive

docker run -d -p 8080:8080 --restart=on-failure -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11

# custom PS1
aws s3 cp s3://lopihara/config/jenkins_server_ps1.sh /etc/ps1.sh
dos2unix /etc/ps1.sh
echo "" >> /etc/bashrc
echo "source /etc/ps1.sh" >> /etc/bashrc