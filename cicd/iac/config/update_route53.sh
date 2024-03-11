#!/bin/bash

pub_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
sed "s/NEW_IP_ADDRESS/$pub_ip/g" /opt/update_route53.json > /opt/new_route53.json
aws route53 change-resource-record-sets --hosted-zone-id Z047808738KXU4X3TXN0Q --change-batch file:///opt/new_route53.json

