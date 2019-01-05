FROM centos:6 as base

RUN yum -y update && yum install -y make \
gtk2.i686 libstdc++.i686 glibc.i686 libX11.i686 libXext.i686 \
libXau.i686 libXdmcp.i686 freetype.i686 fontconfig.i686 \
expat.i686 libpng.i686 libSM.i686 libXrender.i686 \
unixODBC-libs.i686 unixODBC.i686 ncurses.i686 ncurses-libs.i686 \
libzmq3.i686 libXext.i686 alsa-lib.i686 libXtst.i686 libXft.i686 \
libxml2.i686 libedit.i686 libXi.i686 libXft-devel.i686 libXt.i686 \
gtk2 libX11 libXext libXau libXdmcp freetype fontconfig expat libpng \
libSM libXrender unixODBC-libs unixODBC libzmq3 libXext alsa-lib libXtst \
libXft libxml2 libedit libXi libXft-devel libXt \
firefox 'liberation-*-fonts' 'dejavu-*-fonts' && \
groupadd -g 1000 quartus && adduser -u 1000 -g 1000 quartus

FROM base as install
ADD Quartus-web-13.1.0.162-linux.tar /quartus
ADD QuartusSetup-13.1.4.182.run /quartus
RUN mkdir -p /opt/quartus && /quartus/setup.sh --mode unattended --installdir /opt/quartus; /quartus/QuartusSetup-13.1.4.182.run --mode unattended --installdir /opt/quartus

FROM base
COPY --from=install /opt/quartus /opt/quartus 
USER quartus:quartus
CMD ["/opt/quartus/quartus/bin/quartus", "--64bit"]
