#!/bin/sh
accountId=$1
apiKey=$2
gatewayId=$3
linuxUser=$4

curl -u $accountId:$apiKey https://service.itconductor.com/lib/itconductor-gateway-6-65.x86_64.rpm --output /home/$linuxUser/itconductor-gateway-6-65.x86_64.rpm

sudo apt-get update

sudo rpm -U --nodeps  /home/$linuxUser/itconductor-gateway-6-65.x86_64.rpm

sed -i "s-\[ACCOUNTID\]-$accountId-g" /opt/itconductor/conf/AGENT.xml

sed -i "s-\[APIKEY\]-$apiKey-g" /opt/itconductor/conf/AGENT.xml

sed -i "s-\[GATEWAYID\]-$gatewayId-g" /opt/itconductor/conf/AGENT.xml

sudo systemctl stop itconductor-gateway

sudo systemctl start itconductor-gateway
