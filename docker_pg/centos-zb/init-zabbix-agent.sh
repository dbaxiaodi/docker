#!/bin/bash

rpm -ivh http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-release-3.0-1.el7.noarch.rpm --force
yum install -y openssh* zabbix-sender

grep "^zabbix" /etc/passwd >& /dev/null
if [ $? -ne 0 ] ; then
    groupadd -g 1009 zabbix
    useradd -u 1009 -g 1009  zabbix
fi

tar zxf /usr/local/zabbix_agents_3.0.0.linux2_6.amd64.tar.gz -C /usr/local
sed -i -e "s/Server=127.0.0.1/Server=zabbix3.0/g" /usr/local/conf/zabbix_agentd.conf
sed -i -e "s/^ServerActive=127.0.0.1/ServerActive=zabbix3.0/g" /usr/local/conf/zabbix_agentd.conf
#sed -i "s/^Hostname=Zabbix server/Hostname=$HOSTNAME/g" /usr/local/conf/zabbix_agentd.conf
