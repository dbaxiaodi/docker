FROM centos:latest
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);\
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
#CMD ["/usr/sbin/init"]

#RUN yum makecache fast
RUN yum install -y gcc gcc-c++ make vim unzip wget lua-devel lua-static patch libxml2-devel libxslt libxslt-devel gd gd-devel ntp ntpdate openssh-clients python-devel net-tools telnet traceroute curl mlocate sysstat

COPY restart.sh /usr/local/sbin/

#RUN echo "ulimit -S -c 0 > /dev/null2>&1.ok" >> /etc/profile
