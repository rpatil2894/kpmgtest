#!/usr/bin/env bash

id=`curl --silent http://169.254.169.254/latest/meta-data/instance-id`
ip=`curl --silent http://169.254.169.254/latest/meta-data/local-ipv4`
az=$(curl -s -w "\n" 169.254.169.254/latest/meta-data/placement/availability-zone)
intance_type=`/opt/aws/bin/ec2-metadata -t | awk '{print $2}'`

echo "our instance id is $id"
echo "our instnace privagte ip $ip"
echo "our instance availability zone $az"
echo "our instance instance type $instance_type"

exit 0
