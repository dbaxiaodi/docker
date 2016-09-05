#!/bin/bash

#sed -i.bak "s/SELINUX=enforcing/SELINUX=permissive/g" /etc/selinux/config

#rm -rf /etc/yum.repos.d/*
#touch /etc/yum.repos.d/gb.repo
#cat << EOF >> /etc/yum.repos.d/gb.repo
#[gb]
#name=gb
#baseurl=http://192.168.0.101:80/yumrepo/
#enable=1
#gpgcheck=0
#priority=1
#EOF

groupadd -g 1000 postgres
useradd -u 1000 -g 1000 postgres
mkdir -p /var/data/postgres && mkdir /var/data/xlog_archive && chown -R postgres.postgres /var/data

# modify kernel
tee << EOF >> /etc/sysctl.conf
kernel.shmmax = 11719476736
kernel.shmall = 4294967296
kernel.shmmni = 4096	
fs.file-max = 7672460
net.ipv4.ip_local_port_range = 9000 65000
net.core.rmem_default = 1048576
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
kernel.sem = 50100 64128000 50100 1280
EOF

tee << EOF >> /etc/sudoers
postgres        ALL=(ALL) NOPASSWD:     ALL
EOF

# install postgresql
cd /usr/local/src/postgresql-9.5.1
./configure --prefix=/usr/local/postgres --with-pgport=5432 --with-perl --with-tcl --with-python --with-openssl --with-pam \
--with-libxml --with-libxslt --enable-thread-safety --with-wal-blocksize=16 --with-blocksize=8 && gmake world && gmake install-world
su - postgres -c '/usr/local/postgres/bin/initdb -D /var/data/postgres/ -E UTF8 '

# postgres configuration
cat << EOF >> /var/data/postgres/postgresql.conf
listen_addresses = '*'
max_connections = 2000
wal_level = hot_standby
synchronous_commit = on
archive_mode = on
archive_command = 'cp %p /var/data/xlog_archive/%f'
max_wal_senders = 5
wal_keep_segments = 256
hot_standby = on
max_standby_archive_delay = -1
max_standby_streaming_delay = -1
wal_receiver_status_interval = 2s
hot_standby_feedback = on
#log_destination = 'stderr'
log_destination = 'csvlog'
log_statement = 'ddl'
logging_collector = on
log_directory = 'pg_log'
log_filename = 'postgresql-%a.log'
restart_after_crash = off
fsync = off
shared_buffers = 2048MB
log_min_duration_statement = 500
work_mem = 40MB
shared_preload_libraries = 'pg_stat_statements'
#synchronous_commit = on

EOF

cat << EOF >> /var/data/postgres/pg_hba.conf
host    all             all             192.168.0.0/16               md5
host    replication     all             192.168.0.0/16               md5
EOF

cat << EOF >> /home/postgres/.bash_profile
export PGPORT=5432
export PGDATA=/var/data/postgres
export LANG=en_US.utf8
export PGHOME=/usr/local/postgres
export LD_LIBRARY_PATH=\$PGHOME/lib:/lib64:/usr/lib64:/usr/local/lib64:/lib:/usr/lib:/usr/local/lib:\$LD_LIBRARY_PATH
export DATA=`date +"%Y%m%d%H%M"`
export PATH=\$PGHOME/bin:\$PATH.
export PGUSER=postgres
EOF
source /home/postgres/.bash_profile

