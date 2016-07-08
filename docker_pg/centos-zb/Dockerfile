FROM hub:5000/centos-base

#RUN rpm -ivh http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-release-3.0-1.el7.noarch.rpm --force

#RUN yum install -y openssh* zabbix-sender
#add zabbix-agent
COPY zabbix_agents_3.0.0.linux2_6.amd64.tar.gz /usr/local/
COPY init-zabbix-agent.sh /usr/local/
COPY start-zabbix-agentd.sh /usr/local/sbin/
RUN /usr/bin/sh /usr/local/init-zabbix-agent.sh

#ENTRYPOINT /usr/local/sbin/start-zabbix-agentd.sh
