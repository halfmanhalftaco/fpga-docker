FROM	ise-install:14.7 
ARG	user_uid
ARG	user_gid
ARG	user_name
ADD	launch.sh /opt/Xilinx/
RUN     groupadd -g $user_uid $user_name && \
        adduser -u $user_uid -g $user_gid -N -M -d /home/$user_name $user_name
CMD 	["/bin/bash", "-l", "/opt/Xilinx/launch.sh"]

