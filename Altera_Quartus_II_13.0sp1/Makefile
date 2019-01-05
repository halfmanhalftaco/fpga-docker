INSTALLER=Quartus-web-13.0.1.232-linux.tar

all: ${INSTALLER} build

${INSTALLER}:
	curl -O http://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_tar/Quartus-web-13.0.1.232-linux.tar

.PHONY: build
build:
	docker build -t quartusii:13.0sp1 .

.PHONY: run
run:
	docker run -it \
	--user="quartus" \
	--env="DISPLAY" \
	--mac-address=08:00:69:CA:FE:01 \
	--privileged --ipc host \
	--volume="/dev/bus/usb/:/dev/bus/usb/:rw" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--volume="${HOME}/src:/home/quartus/src:rw" \
	quartusii:13.0sp1 /bin/bash

