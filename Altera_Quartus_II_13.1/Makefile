INSTALL=Quartus-web-13.1.0.162-linux.tar
UPDATE=QuartusSetup-13.1.4.182.run


all: download build

${INSTALL}:
	curl -O http://download.altera.com/akdlm/software/acdsinst/13.1/162/ib_tar/Quartus-web-13.1.0.162-linux.tar
	
${UPDATE}:
	curl -O http://download.altera.com/akdlm/software/acdsinst/13.1.4/182/update/QuartusSetup-13.1.4.182.run

download: ${INSTALL} ${UPDATE}
	
.PHONY: build
build: ${INSTALL} ${UPDATE}
	docker build -t quartusii:13.1 .

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
	quartusii:13.1

