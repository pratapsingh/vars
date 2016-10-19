#!/bin/bash
region=$1
profile=$2
vpc_id=`echo $4 |cut -d" " -f1`

echo -e "import boto\nfrom boto.vpc import VPCConnection\nv = boto.vpc.connect_to_region('$1',profile_name='$2')\nfor i in v.get_all_subnets(filters={'vpc_id': '$vpc_id','availability_zone': '$3'}): print i.id, i.cidr_block, i.tags['Name']" | python
