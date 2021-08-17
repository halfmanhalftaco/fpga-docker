TOOL=quartus2011

URL=https://download.altera.com/akdlm/software/acdsinst/20.1std.1/720/ib_tar/Quartus-lite-20.1.1.720-linux.tar
INSTALLER=Quartus-lite-20.1.1.720-linux.tar
CHECKSUM=0BEBCAECE9D8A03AF9A69A48ADC45634
ECLIPSE_URL=https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/mars/2/eclipse-cpp-mars-2-linux-gtk-x86_64.tar.gz
ECLIPSE=eclipse-cpp-mars-2-linux-gtk-x86_64.tar.gz
ECLIPSE_CHECKSUM=82ecb7c19323004e08fd1bbac8564820

FILES=$(INSTALLER) $(ECLIPSE) Dockerfile

all: container-image-built

${INSTALLER}:
	curl -O $(URL)
	@SUM=$$(md5sum $(INSTALLER) | awk '{print toupper($$1)}'); \
		if [ "$$SUM" != "$(CHECKSUM)" ]; then echo "Checksum doesn't match."; exit 1; fi

${ECLIPSE}:
	curl -LO "$(ECLIPSE_URL)"
	@SUM=$$(md5sum $(ECLIPSE) | awk '{print toupper($$1)}'); \
		if [ "$$SUM" != "$(ECLIPSE_CHECKSUM)" ]; then echo "Checksum doesn't match."; exit 1; fi

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
