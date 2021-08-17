FROM fpga-base:centos6 as install
LABEL com.halfmanhalftaco.fpga.temp=1
ADD Quartus-lite-16.0.2.222-linux.tar /quartus
RUN mkdir -p /opt/quartus && /quartus/setup.sh --mode unattended --installdir /opt/quartus 

FROM fpga-base:centos6
COPY --from=install /opt/quartus /opt/quartus 
CMD ["/opt/quartus/quartus/bin/quartus", "--64bit"]
ARG TOOL
LABEL com.halfmanhalftaco.fpga.tool=$TOOL
