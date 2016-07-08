FROM hub:5000/centos-zb

MAINTAINER Chan <root@localhost>
ADD postgresql-9.5.1.tar.gz /usr/local/src/
ADD pg_monz-2.0.tar.gz /usr/local/

RUN rpm -ivh http://mirrors.163.com/centos/7/os/x86_64/Packages/centos-release-7-2.1511.el7.centos.2.10.x86_64.rpm --force && \
    rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-7.noarch.rpm --force
RUN yum clean all && yum makecache fast
RUN yum install -y perl-ExtUtils-MakeMaker perl-ExtUtils-Embed openssl openssl-devel pam pam-devel tcl tcl-devel flex flex-devek python-devel ncurses-devel readline-devel zlib-devel sendmail pacemaker pcs psmisc policycoreutils-python bison sudo supervisor crontabs

COPY pg_monz.sh install.sh /root/

RUN /usr/bin/sh /root/pg_monz.sh
RUN /usr/bin/sh /root/install.sh
