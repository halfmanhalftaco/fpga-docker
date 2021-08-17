FROM fpga-base:centos6 as install
LABEL com.halfmanhalftaco.fpga.temp=1
ADD Quartus-web-13.1.0.162-linux.tar /quartus
ADD QuartusSetup-13.1.4.182.run /quartus
RUN chmod 755 /quartus/*.run && \
quartus/setup.sh --mode unattended --installdir /opt/quartus && \\
/quartus/QuartusSetup-13.1.4.182.run --mode unattended --installdir /opt/quartus

FROM fpga-base:centos6
COPY --from=install /opt/quartus /opt/quartus 
CMD ["/opt/quartus/quartus/bin/quartus", "--64bit"]
ARG TOOL
LABEL com.halfmanhalftaco.fpga.tool=$TOOL