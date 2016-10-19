#!/bin/bash
region=$1
profile=$2
vpc_id=`echo $3 |cut -d" " -f1`
/usr/bin/python get_security_group.py $region $profile $vpc_id
