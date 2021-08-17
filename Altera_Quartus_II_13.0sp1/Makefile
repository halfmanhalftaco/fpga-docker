TOOL=quartus13
INSTALLER=Quartus-web-13.0.1.232-linux.tar

all: container-image-built

$(INSTALLER):
	curl -O http://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_tar/Quartus-web-13.0.1.232-linux.tar

container-image-built: $(INSTALLER) Dockerfile
	@docker rmi fpga:$(TOOL) &>/dev/null || true
	@docker build -t fpga:$(TOOL) --build-arg "TOOL=$(TOOL)" .
	@docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp" -q)
	@touch $@

.PHONY: clean
clean:
	docker rmi fpga:$(TOOL) >&/dev/null || true
	docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.tool=$(TOOL)" -q)
	docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp" -q)
	rm -f container-image-built
