####

#Prerequisite:

Before begining with the job creation make sure you have "Active choices reactive parameter plugin" installed under your Jenkins. As we are going to use that alot here. 
Install boto and configure boto credential under user running Jenkins.
Create proper IAM role for AWS user to launch instance, create disk, elastic IP

Basic knowledge of Ansible and working with playbook is must. 


#Here we go
Create A new item in jenkins with the name "Project name" as "Instance_Creation"

Click on "This build is parameterized"

Click on Add Parameter # I assume that you know how to add parameter to parameterized build
#1: Choice Paramter: 
      Select_Account : 
         Production
         Development
#2: Choice Paramter:
       Select_Region : 
           Enter all regions here used under your aws account 
#3: Active Choices Reactive Parameter:
       Name: Availability_Zone:
         Groovy Script
           Paste the groovy script "Availability_zone.groovy" content here and modify path of your shell/python scripp
         Single Select
         Referenced Parameter: Select_Region,Select_Account
#4: Active Choices Reactive Parameter:
       Name: VPC_ID:
         Groovy Script
           Paste the groovy script "VPC_ID.groovy" content here and modify path of your shell/python scripp
         Single Select
         Referenced Parameter: Select_Region,Select_Account
#5: Active Choices Reactive Parameter:
       Name: Subnet_ID:
         Groovy Script
           Paste the groovy script "Subnet_ID.groovy" content here and modify path of your shell/python scripp
         Single Select
         Referenced Parameter: Select_Region,Select_Account,Availability_Zone,VPC_ID
#6: Active Choices Reactive Parameter:
       Name: Security_Groups:
         Groovy Script
           Paste the groovy script "Security_Groups.groovy" content here and modify path of your shell/python scripp
         Single Select
         Referenced Parameter: Select_Region,Select_Account,VPC_ID,Subnet_ID
#7: Active Choices Reactive Parameter:
       Name: KeyPair:
         Groovy Script
           Paste the groovy script "KeyPair.groovy" content here and modify path of your shell/python scripp
         Single Select
         Referenced Parameter: Select_Region,Select_Account
#7: Choice parameter
   Name: Select_AMI
         Enter your all ami name in list
#8: Choice Parameter
   Name: Instance_Type
        Enter instance type in list
#9: Choice Parameter
   Name: Disk_Type
         Enter disk types
#10: Validate string Parameter
   Name: Disk_Size
   Default 0
   Regx: [0-9]+
#11: Validate string Parameter
   Name: Name_Tag
   Default 
   Regx: .+
#12: Validate string Parameter
   Name: Email_Tag
   Default 
   Regx: .*@gmail.com
#13: Validate string Parameter
   Name: Team_Tag
   Default 
   Regx: .+
#14: Validate string Parameter
   Name: Project_Tag
   Default 
   Regx: .+
#15: Choice Parameter
   Name: Environment_Tag
   Enter list of your env to choose from
#16: Public_IP_Required
   Name: Public_IP_Required
   Single Select
   Value: None,Public_IP, Elastic_IP
#17: Text Parameter
    Name: User_Data
    Enter the user data. Eache shell script line should be terminated with ';' .
#18: Boolean Parameter
    Name: Enable_Monitoring

That is all. Copy the files at server and modify the path as per location on the server and wait for magic to happen









