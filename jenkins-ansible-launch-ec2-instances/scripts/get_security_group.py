#!/usr/bin/python
import boto, sys
from boto import ec2
region=sys.argv[1]
profile=sys.argv[2]
vpc_id=sys.argv[3]
conn = boto.ec2.connect_to_region(region,profile_name=profile)
groups = conn.get_all_security_groups(filters={'vpc_id': vpc_id})
if groups:
        for g in groups:
                rules = g.rules
                if rules:
                        ruleStr = ""
                        for r in range(len(rules)):
                                protocol = rules[r].ip_protocol
                                from_port = rules[r].from_port
                                to_port = rules[r].to_port
                                grants = rules[r].grants
                                if r == 0:
                                        ruleStr = ""
                                else:
                                        ruleStr = ruleStr + ''
                                if protocol:
                                        ruleStr = ruleStr + 'Protocol: ' + protocol
                                if to_port:
                                        ruleStr = ruleStr + ' | To Port: ' + to_port
                                if grants:
                                        ruleStr = ruleStr + ' | Grants: ' + str(grants).strip('[]')
                        print g.id, g.name, ruleStr
