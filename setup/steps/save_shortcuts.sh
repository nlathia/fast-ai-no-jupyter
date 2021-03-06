#!/bin/bash

echo Creating shortcuts...
rm -f $name-*.sh

## export vars to be sure
echo \# Your setup variables: > $name-variables.sh
echo export profileName=$profileName >> $name-variables.sh
echo export instanceId=$instanceId >> $name-variables.sh
echo export instanceName=$instanceName >> $name-variables.sh
echo export subnetId=$subnetId >> $name-variables.sh
echo export securityGroupId=$securityGroupId >> $name-variables.sh
echo export instanceUrl=$instanceUrl >> $name-variables.sh
echo export routeTableId=$routeTableId >> $name-variables.sh
echo export name=$name >> $name-variables.sh
echo export assocId=$assocId >> $name-variables.sh
echo export vpcId=$vpcId >> $name-variables.sh
echo export internetGatewayId=$internetGatewayId >> $name-variables.sh
echo export subnetId=$subnetId >> $name-variables.sh
echo export routeTableAssoc=$routeTableAssoc >> $name-variables.sh
echo export allocAddr=$allocAddr >> $name-variables.sh
echo export routeTableAssoc=$routeTableAssoc >> $name-variables.sh
echo export name=$name >> $name-variables.sh

echo \# Connect to your instance: > $name-connect.sh
echo ssh -i ~/.ssh/aws-key-$name.pem ubuntu@$instanceUrl >> $name-connect.sh
chmod u+x $name-connect.sh

echo \# Stop your instance: > $name-stop.sh
echo ". $(dirname "$0")/$name-variables.sh" >> $name-stop.sh
echo ". $(dirname "$0")/steps/stop_instance.sh" >> $name-stop.sh
chmod u+x $name-stop.sh

echo \# Start your instance: > $name-start.sh
echo ". $(dirname "$0")/$name-variables.sh" >> $name-start.sh
echo ". $(dirname "$0")/steps/start_instance.sh" >> $name-start.sh
chmod u+x $name-start.sh

echo \# Reboot your instance: >> $name-reboot.sh
echo aws ec2 reboot-instances --instance-ids $instanceId --profile $profileName  >> $name-reboot.sh
chmod u+x $name-reboot.sh