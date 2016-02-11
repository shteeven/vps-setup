#!/bin/bash

################################
# Get VPS login data from user
################################

echo "Please enter the VPS ip: "
read vps_ip
echo "You entered: $vps_ip"

echo "Please enter RSA file name: "
echo "Ensure that the file is in '~/.ssh/' "
read vps_rsa
echo "You entered: $vps_rsa"

################################
# Log into VPS via SSH
################################

ssh -i ~/.ssh/$vps_rsa root@$vps_ip
echo "I can run here"
cd ../../
ls -al

