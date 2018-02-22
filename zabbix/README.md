#Run This script to download all these file to your server and then you can modify them
#!/bin/bash 
sudo wget -O /usr/local/bin/lld-disks.py  https://raw.githubusercontent.com/pratapsingh/vars/master/zabbix/lld-disks.py 
sudo chmod 755 /usr/local/bin/lld-disks.py
sudo wget -O /etc/zabbix/zabbix_agentd.d/mysql.cfg https://raw.githubusercontent.com/pratapsingh/vars/master/zabbix/mysql.cfg
echo -e "=================================================================="
echo -e "Modify Value in this file : /etc/zabbix/zabbix_agentd.d/mysql.cfg"
echo -e "=================================================================="
sudo wget -O /etc/zabbix/zabbix_agentd.d/mysql.sh https://raw.githubusercontent.com/pratapsingh/vars/master/zabbix/mysql.sh
sudo chmod 755 /etc/zabbix/zabbix_agentd.d/mysql.sh
echo -e "=================================================================="
echo -e "Modify Value in this file : /etc/zabbix/zabbix_agentd.d/mysql.sh"
echo -e "=================================================================="
sudo wget -O /etc/zabbix/zabbix_agentd.d/mysql_helpers.sh https://raw.githubusercontent.com/pratapsingh/vars/master/zabbix/mysql_helpers.sh
sudo wget -O /etc/zabbix/zabbix_agentd.d/userparameter_diskstats.conf https://raw.githubusercontent.com/pratapsingh/vars/master/zabbix/userparameter_diskstats.conf
sudo wget -O /etc/zabbix/zabbix_agentd.d/userparameter_mysql_slave.conf https://raw.githubusercontent.com/pratapsingh/vars/master/zabbix/userparameter_mysql_slave.conf
