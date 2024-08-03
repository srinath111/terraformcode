#!/bin/bash
I=0
while [ $I -lt 11 ]
do
echo $I
sleep 1
I=$(( $I + 1))
done

#cd /tmp
#wget https://releases.hashicorp.com/terraform/1.7.4/terraform_1.7.4_linux_amd64.zip
#DATE=$(date)