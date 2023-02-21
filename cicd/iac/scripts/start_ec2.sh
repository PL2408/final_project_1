#!/bin/bash

# jenkins_server
aws ec2 start-instances --instance-ids $(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --filters "Name=tag:Name,Values=jenkins_server" --output text)

# agent
aws ec2 start-instances --instance-ids $(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --filters "Name=tag:Name,Values=jenkins_agent" --output text)

# web_server
aws ec2 start-instances --instance-ids $(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --filters "Name=tag:Name,Values=web_server" --output text)

#aws ec2 start-instances --instance-ids i-0eddf65237f4cbd6e --output text
#aws ec2 start-instances --instance-ids i-0070423e159f6177a --output text



