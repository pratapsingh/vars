#!/bin/bash

subnet=`echo $Subnet_ID | awk {'print $1'}`
sg=`echo $Security_Groups | awk {'print $1'}` 

vpc=`echo $VPC_ID | awk {'print $1'}`

#Select_AMI='ami-21d30f47' #to test 

touch /tmp/ec2_user_data.sh
echo $User_Data > /tmp/ec2_user_data.sh

/bin/bash /path/to/deploy_instance.sh $Select_Account $Select_Region $vpc $subnet $sg $KeyPair $az $Select_AMI $Instance_Type $Disk_Type $Disk_Size $Name_Tag $Email_Tag $Team_Tag $Project_Tag $Environment_tag $Public_IP_Required $Enable_Monitoring 
