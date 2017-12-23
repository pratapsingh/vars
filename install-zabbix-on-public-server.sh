#!/bin/bash
# Script is written to install zabbix on fresh new instance/host. You need to run the script as mentioned below
# /bin/bash zabbix_active-agent_installation.sh webserver facebook-app
# Where webserver is desired hostname or group/service it belongs to, then HostMetadata is AutoRegistration Action created under zabbix
# for your project/team
# /bin/bash zabbix-installtion.sh vpn.internal devops zabbix.internal 3
Hostname=${1}
Hostmetadata=${2}
SERVER=${3}  #zabbix server ip or fqdn name
SA=${4}
if [[ ! -z `dpkg -l | grep -i zabbix` ]] ;then
  echo -e "\nZabbix agent already installed\n";
else

  if [[ "${SA}" -gt 0 ]] ; then
    #IP=`hostname -I | awk {'print $1'}`
    #IP=`ip r |grep "dev eth0"| tail -1 | awk {'print $NF'}`
    IP=`curl wgetip.com`
  else
    IP='0.0.0.0'
  fi

  if which lsb_release &>> /dev/null; then
    OS=`lsb_release -a | sed -n 's/.*\(Ubuntu\).*/\1/p; s/.*\(Amazon\).*/\1/p; s/.*\(Debian\).*/\1/p' | head -1`
  elif [[ -r /etc/issue ]]; then
    OS=`cat /etc/issue | head -1 | awk {'print $1'}`
  else
    echo "Oops!! Unknown OS"
  fi


  echo -e"Operation System ===> $OS\n"
  echo -e "\nBegning Zabbix agent installation on OS -> $OS on host `hostname -I`"
  echo -e "\n============================================================================================\n"

  case "$OS" in
  "Ubuntu")
        URL='http://repo.zabbix.com/zabbix/3.2/ubuntu/pool/main/z/zabbix/zabbix-agent_3.2.0-1+trusty_amd64.deb'
        cd /tmp; apt-get  update; apt-get install wget telnet -y ; apt-get install lsb-core libodbc1 libltdl7  libcurl3 -y ; wget $URL ; dpkg -i zabbix-agent_*.deb ; rand=`hostname -I` ; HOSTNAME=${Hostname} ; sed -i "s/Hostname=.*/Hostname=${HOSTNAME}-${rand}/g" /etc/zabbix/zabbix_agentd.conf; sed -i "s/Server=127.0.0.1/Server=${SERVER}/g" /etc/zabbix/zabbix_agentd.conf; sed -i "s/ServerActive=127.0.0.1/ServerActive=${SERVER}/g" /etc/zabbix/zabbix_agentd.conf; sed -i "/# HostMetadata=/aHostMetadata=${Hostmetadata}" /etc/zabbix/zabbix_agentd.conf; sed -i "/StartAgents=3/aStartAgents=${SA}" /etc/zabbix/zabbix_agentd.conf; sed -i "/# ListenIP=0.0.0.0/a ListenIP=${IP}" /etc/zabbix/zabbix_agentd.conf ; sed -i "/# EnableRemoteCommands=0/EnableRemoteCommands=1/g" /etc/zabbix/zabbix_agentd.conf;  /etc/init.d/zabbix-agent restart; rm /tmp/zabbix-agent*;
  ;;

  "Debian")
        URL='http://repo.zabbix.com/zabbix/3.2/debian/pool/main/z/zabbix/zabbix-agent_3.2.0-1+jessie_amd64.deb'
        cd /tmp; apt-get  update; apt-get install wget telnet -y ; apt-get install lsb-core libodbc1 libltdl7  libcurl3 -y ; wget $URL ; dpkg -i zabbix-agent_*.deb; rand=`hostname -I` ; sed -i "s/Hostname=.*/Hostname=${Hostname}-${rand}/g" /etc/zabbix/zabbix_agentd.conf; sed -i "s/Server=127.0.0.1/Server=${SERVER}/g" /etc/zabbix/zabbix_agentd.conf; sed -i "s/ServerActive=127.0.0.1/ServerActive=${SERVER}/g" /etc/zabbix/zabbix_agentd.conf; sed -i "/# HostMetadata=/aHostMetadata=$Hostmetadata" /etc/zabbix/zabbix_agentd.conf; sed -i "/StartAgents=3/aStartAgents=${SA}" /etc/zabbix/zabbix_agentd.conf; sed -i "/# ListenIP=0.0.0.0/a ListenIP=${IP}" /etc/zabbix/zabbix_agentd.conf ;sed -i "/# EnableRemoteCommands=0/EnableRemoteCommands=1/g" /etc/zabbix/zabbix_agentd.conf; /etc/init.d/zabbix-agent start; rm /tmp/zabbix-agent*; /etc/init.d/zabbix-agent restart
  ;;

  "Amazon")
        URL='http://repo.zabbix.com/zabbix/3.2/rhel/6/x86_64/zabbix-agent-3.2.0-1.el6.x86_64.rpm'

        yum update -y ; yum install unixODBC.x86_64  -y ; wget $URL; rpm -ivh zabbix-agent-*.rpm; rand=`hostname -I` ; sed -i "s/Hostname=.*/Hostname=${Hostname}-${rand}/g" /etc/zabbix/zabbix_agentd.conf; sed -i "s/Server=127.0.0.1/Server=${SERVER}/g" /etc/zabbix/zabbix_agentd.conf; sed -i "s/ServerActive=127.0.0.1/ServerActive=${SERVER}/g" /etc/zabbix/zabbix_agentd.conf; sed -i "/# HostMetadata=/aHostMetadata=${Hostmetadata}" /etc/zabbix/zabbix_agentd.conf; sed -i "/StartAgents=3/aStartAgents=${SA}" /etc/zabbix/zabbix_agentd.conf; sed -i "/# ListenIP=0.0.0.0/a ListenIP=${IP}" /etc/zabbix/zabbix_agentd.conf ; sed -i "/# EnableRemoteCommands=0/EnableRemoteCommands=1/g" /etc/zabbix/zabbix_agentd.conf; /etc/init.d/zabbix-agent restart; rm /tmp/zabbix-agent*;

  esac

  sleep 10

  # diskstats user parameters config
  sudo mkdir -p /etc/zabbix/zabbix_agentd.d/
  sudo wget https://raw.githubusercontent.com/grundic/zabbix-disk-performance/master/userparameter_diskstats.conf -O /etc/zabbix/zabbix_agentd.d/userparameter_diskstats.conf

  # low level discovery script
  sudo wget https://raw.githubusercontent.com/grundic/zabbix-disk-performance/master/lld-disks.py -O /usr/local/bin/lld-disks.py
  sudo chmod +x /usr/local/bin/lld-disks.py

  sudo service zabbix-agent restart
fi
