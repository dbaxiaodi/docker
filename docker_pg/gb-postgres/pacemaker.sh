#!/bin/bash


## #node all
/etc/init.d/pcsd start
echo "hacluster:hacluster" |chpasswd
#
## #node only one
pcs cluster auth 192.168.3.1 192.168.3.2 192.168.3.3 -u hacluster -p hacluster
pcs cluster setup --name pgcluster 192.168.3.1 192.168.3.2 192.168.3.3
pcs cluster start --all
#
cd /var/data/
sh cluster_setup.sh
#
pcs cluster start --all
#nohup /usr/sbin/pacemakerd -f &
#nohup /usr/sbin/corosync -f &

