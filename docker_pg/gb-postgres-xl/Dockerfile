FROM hub:5000/centos-pg
MAINTAINER Chan <root@localhost>

#COPY supervisord.conf /etc/
COPY entrypoint.sh start.sh stop.sh /usr/local/sbin/
#RUN yum install https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-redhat95-9.5-2.noarch.rpm
#RUN yum install postgresql-server -y
COPY postgresql.service zabbix-agent.service /usr/lib/systemd/system/
COPY postgresql-check /usr/local/postgres/bin/
RUN systemctl disable sendmail.service
#RUN systemctl enable postgresql.service
RUN systemctl enable zabbix-agent.service
RUN chmod +x /usr/local/sbin/*

####make install postgres-xl
ADD postgres-xl-9.5r1.1.tar.gz /usr/local/src/
RUN yum install -y flex bison readline-devel zlib-devel openjade docbook-style-dsssl
COPY install_pgxl.sh pgxc_ctl.conf /usr/local/src/
RUN /usr/bin/sh /usr/local/src/install_pgxl.sh

CMD ["/usr/sbin/init"]

#######
# cluster script
#COPY pacemaker.sh /var/data/
#COPY cluster_setup.sh /var/data/
#启动进程配置，pg，zb
#CMD /usr/local/sbin/start-supervisord.sh  && /bin/bash
#CMD /usr/bin/supervisord && /bin/bash

#CMD /usr/bin/supervisord && /bin/bash
#ENTRYPOINT /usr/local/sbin/start-zabbix-agentd.sh
# && /usr/local/sbin/start-supervisord.sh

