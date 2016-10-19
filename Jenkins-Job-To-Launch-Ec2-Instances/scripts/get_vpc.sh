#!/bin/bash
echo -e "import boto\nfrom boto.vpc import VPCConnection\nv = boto.vpc.connect_to_region('$1',profile_name='$2')\nfor i in  v.get_all_vpcs(): print i.id,i.tags['Name']" | python
