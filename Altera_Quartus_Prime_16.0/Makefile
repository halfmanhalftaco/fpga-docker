TOOL=quartus16

URL=https://download.altera.com/akdlm/software/acdsinst/16.0.2/222/ib_tar/Quartus-lite-16.0.2.222-linux.tar
INSTALLER=Quartus-lite-16.0.2.222-linux.tar
INSTALLER_CHECKSUM=FE3C46D6AA6B3F08AEFF0666796E12EE

FILES=$(INSTALLER) Dockerfile

all: container-image-built

${INSTALLER}:
	curl -O $(URL)
	echo "Comparing checksum..."
	@SUM=$$(md5sum $(INSTALLER) | awk '{print toupper($$1)}'); \
        if [ "$$SUM" != "$(INSTALLER_CHECKSUM)" ]; then echo "Installer checksum doesn't match."; exit 1; fi
	
container-image-built: $(FILES)
	@docker rmi fpga:$(TOOL) &>/dev/null || true
	@docker build --rm -t fpga:$(TOOL) --build-arg "TOOL=$(TOOL)" .
	@docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp=1" -q)
	@touch $@

.PHONY: clean
clean:
	-docker rmi $(TAG) >&/dev/null
	-docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp=1" -q)
	-docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.tool=$(TOOL)" -q)
	-rm -f container-image-built

