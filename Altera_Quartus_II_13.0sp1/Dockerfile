FROM fpga-base as install
ADD Quartus-web-13.0.1.232-linux.tar /quartus
RUN mkdir -p /opt/quartus && /quartus/setup.sh --mode unattended --installdir /opt/quartus

FROM fpga-base
ARG user_uid
ARG user_gid
ARG user_name
RUN 	groupadd -g $user_uid $user_name && \
	adduser -u $user_uid -g $user_gid -N -M -d /home/$user_name $user_name 
	
COPY --from=install /opt/quartus /opt/quartus 
CMD ["/opt/quartus/quartus/bin/quartus", "--64bit"]
