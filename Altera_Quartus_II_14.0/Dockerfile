FROM fpga-base:centos6 as install
LABEL com.halfmanhalftaco.fpga.temp=1
ADD Quartus-web-14.0.0.200-linux.tar /quartus
ADD *.run /quartus/
RUN mkdir -p /opt/quartus && chmod 755 /quartus/*.run \
&& /quartus/setup.sh --mode unattended --installdir /opt/quartus \
&& /quartus/QuartusSetup-14.0.2.209-linux.run --mode unattended --installdir /opt/quartus \
&& /quartus/ModelSimSetup-14.0.2.209-linux.run --mode unattended --installdir /opt/quartus \
&& /quartus/AOCLSetup-14.0.2.209-linux.run --mode unattended --installdir /opt/quartus \
&& /quartus/SoCEDSSetup-14.0.2.274-linux.run --mode unattended --installdir /opt/quartus

FROM fpga-base:centos6
COPY --from=install /opt/quartus /opt/quartus 
CMD ["/opt/quartus/quartus/bin/quartus", "--64bit"]
ARG TOOL
LABEL com.halfmanhalftaco.fpga.tool=$TOOL