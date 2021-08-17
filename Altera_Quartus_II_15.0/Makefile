TOOL=quartus15

URL=https://download.altera.com/akdlm/software/acdsinst/15.0.2/153/ib_tar/Quartus-web-15.0.2.153-linux.tar
INSTALLER=Quartus-web-15.0.2.153-linux.tar
INSTALLER_CHECKSUM=B087BFA443C97FCC9A8904FB73691AD1

FILES=$(INSTALLER) Dockerfile

all: container-image-built

${INSTALLER}:
	curl -O $(URL)
	@SUM=$$(md5sum $(INSTALLER) | awk '{print toupper($$1)}'); \
        if [ "$$SUM" != "$(INSTALLER_CHECKSUM)" ]; then echo "Installer checksum doesn't match."; exit 1; fi
	
container-image-built: $(FILES)
	@docker rmi fpga:$(TOOL) &>/dev/null || true
	@docker build -t fpga:$(TOOL) --build-arg "TOOL=$(TOOL)" . 
	docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp" -q)
	@touch $@

.PHONY: clean
clean:
	docker rmi fpga:$(TOOL) >&/dev/null || true
	docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.tool=$(TOOL)" -q)
	docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp" -q)
	rm -f container-image-built

