FROM centos:7
RUN yum install -y epel-release && yum update -y && yum install -y \
'xorg-x11-fonts-*' dejavu-{sans,sans-mono,serif}-fonts 'liberation-*-fonts' \
xorg-x11-xauth xterm openmotif firefox \
&& yum clean all && rm -rf /var/cache/yum
