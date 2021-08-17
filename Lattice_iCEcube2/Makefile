#INSTALLER=iCEcube2setup_Sep_12_2017_1708.tgz
INSTALLER=iCEcube2setup_Dec_10_2020_2012
ARCHIVE=iCEcube2setup_Dec_10_2020_2012_lin.zip

FILES=Dockerfile.installer Dockerfile.build license.dat ${INSTALLER}

all: container-image-built

${ARCHIVE}:
	curl -O http://files.latticesemi.com/iCE/iCEcube2setup_Dec_10_2020_2012_lin.zip

${INSTALLER}: ${ARCHIVE}
#	curl -O http://files.latticesemi.com/iCE/iCEcube2setup_Sep_12_2017_1708.tgz
	unzip iCEcube2setup_Dec_10_2020_2012_lin.zip

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
	@docker rmi fpga:icecube2 icecube2:installer &>/dev/null || true
	@echo "Building installer image..."
	@docker build -t icecube2:installer -f Dockerfile.installer .
	@echo "Launching installer..."
	@docker run -it \
	  -e DISPLAY=$$(../scripts/gen-xauth icecube2 .Xauthority) \
	  --name="icecube2-installer" \
	  -h icecube2 \
	  -v ${CURDIR}/.Xauthority:/root/.Xauthority \
	  -v /tmp/.X11-unix:/tmp/.X11-unix \
	  icecube2:installer
	@docker commit icecube2-installer icecube2:installed
	@docker build -t fpga:icecube2 -f Dockerfile.build 
	@docker rm icecube2-installer &>/dev/null
	@docker rmi icecube2:installer icecube2:installed &>/dev/null
	@docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp=1" -q)
	@touch $@

.PHONY: clean
clean:
	-docker rm icecube2-installer &>/dev/null
	-docker rmi icecube2:installer icecube2:installed icecube2 &>/dev/null
	-docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp=1" -q)
	@rm -f container-image-built
