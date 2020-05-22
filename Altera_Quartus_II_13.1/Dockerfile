FROM fpga-base as install
ADD Quartus-web-13.1.0.162-linux.tar /quartus
ADD QuartusSetup-13.1.4.182.run /quartus
RUN mkdir -p /opt/quartus && chmod 755 /quartus/*.run \
&& /quartus/setup.sh --mode unattended --installdir /opt/quartus \
&& /quartus/QuartusSetup-13.1.4.182.run --mode unattended --installdir /opt/quartus

FROM fpga-base
ARG	user_uid
ARG	user_gid
ARG	user_name
RUN     groupadd -g $user_gid $user_name && \
        adduser -u $user_uid -g $user_uid -N -M -d /home/$user_name $user_name
COPY --from=install /opt/quartus /opt/quartus 
CMD ["/opt/quartus/quartus/bin/quartus", "--64bit"]
