#!/bin/bash
#1.ssh-keygen problem only

tee << EOF >> /etc/sudoers
postgres        ALL=(ALL) NOPASSWD:     ALL
EOF

sed -i "s/Defaults    requiretty/#Defaults    requiretty/g" /etc/sudoers
/usr/bin/echo postgres:postgres |chpasswd

tee << END >> /home/postgres/pgxl.sh
ssh-keygen -t dsa -f ~/.ssh/id_rsa -N ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
sudo sed -i -r 's/^(.*pam_nologin.so)/#\1/' /etc/pam.d/sshd
sudo chmod u+s /bin/ping
sudo scp ~/.ssh/authorized_keys postgres@postgres-xl.d3:~/.ssh/
END
su - postgres -c 'sh /home/postgres/pgxl.sh'

rm -rf /usr/local/postgres/*
cd /usr/local/src/postgres-xl-9.5r1.1
./configure --prefix=/usr/local/postgres/ --with-perl --with-tcl --with-python --with-openssl --with-pam --with-libxml --with-libxslt --enable-thread-safety --with-wal-blocksize=16 --with-blocksize=8 && gmake world && gmake install-world
cd contrib/
make && make install

tee << EOF >> /home/postgres/.bashrc
export PATH
export PGDATA=/var/data/postgres
export LANG=en_US.utf8
export PGHOME=/usr/local/postgres
export LD_LIBRARY_PATH=$PGHOME/lib:/lib64:/usr/lib64:/usr/local/lib64:/lib:/usr/lib:/usr/local/lib:$LD_LIBRARY_PATH
export DATA=201605180619
export PATH=$PGHOME/bin:$PATH
export PGUSER=postgres
EOF
source /home/postgres/.bashrc



