INSTALLER=iCEcube2setup_Sep_12_2017_1708.tgz

FILES=Dockerfile.installer Dockerfile.build license.dat ${INSTALLER}

all: container-image-built

${INSTALLER}:
	curl -O http://files.latticesemi.com/iCE/iCEcube2setup_Sep_12_2017_1708.tgz

license.dat:
	@echo "Please acquire a free license for iCEcube2 at:"
	@echo "http://www.latticesemi.com/Support/Licensing/DiamondAndiCEcube2SoftwareLicensing/iceCube2"
	@echo "Use the ethernet address defined in the run-icecube script (or set your own)."
	@echo "Place the license.dat file in this directory."
	@exit 1

container-image-built: $(FILES)
	@echo "### In the GUI installer, choose /opt/icecube2 as the destination, "
	@echo "### and select /opt/icecube2/license.dat for your license file."
	@echo "### Uncheck the \"Launch ICEcube2 now\" checkbox at the end."
	@docker rm icecube2-installer &>/dev/null || true
	@docker rmi icecube2 icecube2:installer &>/dev/null || true
	@mkdir -p ${CURDIR}/home
	@echo "Building installer..."
	@docker build -t icecube2:installer -f Dockerfile.installer .
	@echo "Launching installer..."
	@docker run -it \
	  -e DISPLAY=$$(../common/gen-xauth icecube2 ${CURDIR}/home/.Xauthority) \
	  --name="icecube2-installer" \
	  -h icecube2 \
	  -v ${CURDIR}/home/.Xauthority:/root/.Xauthority \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  icecube2:installer
	@docker commit icecube2-installer icecube2:installed
	@docker build -t icecube2 -f Dockerfile.build \
	  --build-arg user_uid=$$(id -u) --build-arg user_gid=$$(id -g) \
	  --build-arg user_name=$$(whoami) .
	@docker rm icecube2-installer &>/dev/null
	@docker rmi icecube2:installer icecube2:installed &>/dev/null
	@touch $@

.PHONY: clean
clean:
	-docker rm icecube2-installer &>/dev/null
	-docker rmi icecube2:installer icecube2:installed icecube2 &>/dev/null
	@rm -f container-image-built