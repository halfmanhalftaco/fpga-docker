FROM fpga-base:centos6 as install
ADD Quartus-lite-19.1.0.670-linux.tar /quartus	
ADD	eclipse-cpp-mars-2-linux-gtk-x86_64.tar.gz /
RUN /quartus/setup.sh --mode unattended --accept_eula 1 --installdir /opt/quartus && \
	(cd /opt/quartus/nios2eds/bin && mv /eclipse ./eclipse_nios2 && tar xfvz eclipse_nios2_plugins.tar.gz)
LABEL com.halfmanhalftaco.fpga.temp=1

FROM fpga-base:centos6
COPY --from=install /opt/quartus /opt/quartus
CMD ["/opt/quartus/quartus/bin/quartus", "--64bit"]
LABEL com.halfmanhalftaco.fpga.tool=quartus191
