FROM fpga-base:centos6 as install
LABEL com.halfmanhalftaco.fpga.temp=1
ADD Quartus-lite-20.1.0.711-linux.tar /quartus	
ADD	eclipse-cpp-mars-2-linux-gtk-x86_64.tar.gz /
RUN /quartus/setup.sh --mode unattended --accept_eula 1 --installdir /opt/quartus && \
	(cd /opt/quartus/nios2eds/bin && mv /eclipse ./eclipse_nios2 && tar xfz eclipse_nios2_plugins.tar.gz)

FROM fpga-base:centos6
COPY --from=install /opt/quartus /opt/quartus
CMD ["/opt/quartus/quartus/bin/quartus", "--64bit"]
ARG TOOL
LABEL com.halfmanhalftaco.fpga.tool=$TOOL