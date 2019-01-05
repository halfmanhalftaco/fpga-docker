ETHERNET=08:00:69:CA:FE:01
INSTALLER=iCEcube2setup_Sep_12_2017_1708

all: installer build

${INSTALLER}.tgz:
	curl -O http://files.latticesemi.com/iCE/iCEcube2setup_Sep_12_2017_1708.tgz

${INSTALLER}: ${INSTALLER}.tgz
	tar xfvz ${INSTALLER}.tgz
	
license.dat:
	@echo "Please acquire a free license for iCEcube2 at:"
	@echo "http://www.latticesemi.com/Support/Licensing/DiamondAndiCEcube2SoftwareLicensing/iceCube2"
	@echo "Use the ethernet address defined in the Makefile (currently ${ETHERNET})"
	@echo "Place the license.dat file in this directory."
	@exit 1
	
.PHONY: installer
installer: license.dat ${INSTALLER}
	@echo "In the GUI installer, choose /opt/icecube2 as the destination, "
	@echo "and select /opt/icecube2/license.dat for your license file."
	xhost +local:root
	- docker rm icecube2-installer
	docker build -t icecube2-installer:latest -f Dockerfile.installer .
	docker run -it \
	--env="DISPLAY" \
	--name="icecube2-installer" \
	--mac-address=${ETHERNET} \
	--privileged --ipc host \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--volume="${PWD}:/mnt:ro" \
	icecube2-installer
	xhost -local:root
	
.PHONY: build
build:
	docker commit icecube2-installer icecube2-installer
	docker build -t icecube2:20170912 -f Dockerfile.build .
	docker rm icecube2-installer
	docker rmi icecube2-installer:latest

.PHONY: run
run:
	mkdir -p home
	docker run -it \
	--user="icecube2" \
	--env="DISPLAY" \
	--mac-address=${ETHERNET} \
	--privileged --ipc host \
	--volume="/dev/bus/usb/:/dev/bus/usb/:rw" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--volume="${PWD}/home:/home/icecube2:rw" \
	icecube2:20170912
	
