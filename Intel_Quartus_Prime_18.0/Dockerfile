FROM 	fpga-base:centos6 as install
LABEL   com.halfmanhalftaco.fpga.temp=1
ADD 	Quartus-lite-18.1.0.625-linux.tar /quartus	
RUN 	/quartus/setup.sh --mode unattended --accept_eula 1 --installdir /opt/quartus

FROM 	fpga-base:centos6
COPY 	--from=install /opt/quartus /opt/quartus
CMD 	["/opt/quartus/quartus/bin/quartus", "--64bit"]
ARG     TOOL
LABEL   com.halfmanhalftaco.fpga.tool=$TOOL