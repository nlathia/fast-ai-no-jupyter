#!/bin/bash

echo aws ec2 stop-instances --instance-ids $instanceId --profile $profileName
echo aws ec2 wait instance-stopped --instance-ids $instanceId --profile $profileName

volumeId=$(aws ec2 describe-volumes --profile $profileName --filters "Name=attachment.instance-id,Values=$instanceId" --query "Volumes[0].VolumeId" --output text)

if [ "$volumeId" != "None" ]
  then
    devicePath=$(aws ec2 describe-volumes --profile $profileName --filters "Name=attachment.instance-id,Values=$instanceId" --query "Volumes[0].Attachments[0].Device" --output text)
    snapshotId=$(aws ec2 create-snapshot --volume-id $volumeId --profile $profileName --query "SnapshotId" --output text)

    aws ec2 detach-volume --volume-id $volumeId --profile $profileName
    aws ec2 delete-volume --volume-id $volumeId --profile $profileName
    echo export snapshotId=\$snapshotId > snapshot.sh
    echo export instanceId=$instanceId >> snapshot.sh
    echo export devicePath=$devicePath >> snapshot.sh
    chmod u+x snapshot.sh
else
  echo 'No volumes attached to instance.'
fi
