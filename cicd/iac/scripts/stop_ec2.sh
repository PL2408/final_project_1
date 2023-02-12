#!/bin/bash

# jenkins_server
aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --filters "Name=tag:Name,Values=jenkins_server" --output text)

# agent
aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --filters "Name=tag:Name,Values=jenkins_agent" --output text)

# web_server
aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --filters "Name=tag:Name,Values=web_server" --output text)stop


# stop all instances with tag Project:Final Project 01
#aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --filters "Name=tag:Project,Values=Final project 01" --output text)
