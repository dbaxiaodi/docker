cp /usr/local/pg_monz-2.0/pg_monz/usr-local-etc/* /usr/local/etc/
cp /usr/local/pg_monz-2.0/pg_monz/usr-local-bin/* /usr/local/bin/
cp /usr/local/pg_monz-2.0/pg_monz/zabbix_agentd.d/* /usr/local/conf/zabbix_agentd/
chmod +x /usr/local/bin/*.sh

tee << EOF >> /usr/local/conf/zabbix_agentd.conf
Include=/usr/local/conf/zabbix_agentd/
EOF

mkdir /etc/zabbix/
ln -s /usr/local/conf/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf
