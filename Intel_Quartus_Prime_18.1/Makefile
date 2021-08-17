TOOL=quartus181

URL=http://download.altera.com/akdlm/software/acdsinst/18.1std/625/ib_tar/Quartus-lite-18.1.0.625-linux.tar
INSTALLER=Quartus-lite-18.1.0.625-linux.tar
CHECKSUM=EAF82392603B92DAE632CC0F356B08AA

FILES=$(INSTALLER) Dockerfile

all: container-image-built

${INSTALLER}:
	curl -O $(URL)
	@SUM=$$(md5sum $(INSTALLER) | awk '{print toupper($$1)}'); \
	  if [ "$$SUM" != "$(CHECKSUM)" ]; then echo "Checksum doesn't match."; exit 1; fi

container-image-built: $(FILES)
	@docker rmi fpga:$(TOOL) &>/dev/null || true
	@docker build -t fpga:$(TOOL) --build-arg "TOOL=$(TOOL)" . 
	@docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp=1" -q)
	touch $@

.PHONY: clean
clean:
	-docker rmi fpga:$(TOOL) >&/dev/null || true
	-docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp=1" -q)
	-docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.tool=$(TOOL)" -q)
	-rm -f container-image-built
