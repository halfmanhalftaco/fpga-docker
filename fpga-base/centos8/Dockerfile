FROM centos:8
RUN dnf install -y epel-release && dnf update -y && dnf install -y \
'xorg-x11-fonts-*' dejavu-{sans,sans-mono,serif}-fonts 'liberation-*-fonts' \
xorg-x11-xauth xterm openmotif firefox \
&& dnf clean all
