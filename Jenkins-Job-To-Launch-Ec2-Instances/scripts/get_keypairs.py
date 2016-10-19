#!/usr/bin/python
import boto, sys
from boto import ec2
region=sys.argv[1]
profile=sys.argv[2]
conn = boto.ec2.connect_to_region(region,profile_name=profile)
for i in conn.get_all_key_pairs():
        print i.name
