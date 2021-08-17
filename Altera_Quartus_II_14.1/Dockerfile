FROM fpga-base:centos6 as install
LABEL com.halfmanhalftaco.fpga.temp=1
ADD Quartus-web-14.1.0.186-linux.tar /quartus
ADD QuartusSetup-14.1.1.190-linux.run /quartus
ADD AOCLSetup-14.1.1.190-linux.run /quartus
RUN chmod +x /quartus/*.run && /quartus/setup.sh --mode unattended --installdir /opt/quartus && \
    /quartus/QuartusSetup-14.1.1.190-linux.run --mode unattended --installdir /opt/quartus && \
    /quartus/AOCLSetup-14.1.1.190-linux.run --mode unattended --installdir /opt/quartus

FROM fpga-base:centos6
COPY --from=install /opt/quartus /opt/quartus 
CMD ["/opt/quartus/quartus/bin/quartus", "--64bit"]
ARG TOOL
LABEL com.halfmanhalftaco.fpga.tool=$TOOL
