INSTALLER=Quartus-lite-18.1.0.625-linux.tar
CHECKSUM=EAF82392603B92DAE632CC0F356B08AA

all: ${INSTALLER} build

${INSTALLER}:
	curl -O http://download.altera.com/akdlm/software/acdsinst/18.1std/625/ib_tar/Quartus-lite-18.1.0.625-linux.tar

.PHONY: build
build: ${INSTALLER}
	docker build -t quartusii:18.1 .

.PHONY: run
run:
	mkdir -p home
	docker run -it \
	--user="quartus" \
	--env="DISPLAY" \
	--mac-address=08:00:69:CA:FE:01 \
	--privileged --ipc host \
	--volume="/dev/bus/usb/:/dev/bus/usb/:rw" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--volume="${PWD}/home:/home/quartus:rw" \
	quartusii:18.1

