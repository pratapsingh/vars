#!/bin/bash

# Change to directory for Deployment
#DEPLOYMENT_HOME=/path/to/this/script/folder

cd $DEPLOYMENT_HOME

export ANSIBLE_FORCE_COLOR=true

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

#$Select_Account $Select_Region $vpc $subnet $sg $KeyPair $az $Select_AMI $Instance_Type $Disk_Type $Disk_Size $Name_Tag $Email_Tag $Team_Tag $Project_Tag $Environment_tag $Public_IP_Required $Enable_Monitoring 


/usr/local/bin/ansible-playbook ec2_launch.yml -vv -i localhost --extra-vars "Account=$1 Region=$2 Subnet_ID=$4 Security_Groups=$5 KeyPair=$6 Availability_Zone=$7 AMI_ID=$8 Instance_Type=$9 Disk_Type=${10} Disk_Size=${11} Name_Tag=${12} Email_Tag=${13} Team_Tag=${14} Project_Tag=${15} Environment_Tag=${16} Public_IP_Required=${17} Enable_Monitoring=${18}"


if [ $? -ne 0 ]
then
	echo "${red}Build failed , Check build logs" ${reset}
        exit 1
else
	echo "${green}Finished Build at " `date` ${reset}
fi
