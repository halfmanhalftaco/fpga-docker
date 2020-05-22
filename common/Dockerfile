FROM centos:6
RUN yum install -y epel-release && yum update -y && yum install -y \
gtk2{,.i686} unixODBC{,.i686} libxml2{,.i686} libXt.i686 libXtst.i686 libXdmcp.i686 \
xorg-x11-fonts dejavu-{sans,sans-mono,serif}-fonts 'liberation-*-fonts' \
xorg-x11-xauth xterm openmotif firefox \
&& yum clean all && rm -rf /var/cache/yum \
&& ln -sf usr/lib64/libXm.so.4.0.3 /usr/lib64/libXm.so.3 && ldconfig 
