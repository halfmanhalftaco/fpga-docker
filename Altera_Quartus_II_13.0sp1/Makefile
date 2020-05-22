INSTALLER=Quartus-web-13.0.1.232-linux.tar

all: container-image-built

$(INSTALLER):
	curl -O http://download.altera.com/akdlm/software/acdsinst/13.0sp1/232/ib_tar/Quartus-web-13.0.1.232-linux.tar

container-image-built: $(INSTALLER)
	@docker rmi quartusii:13.0sp1 &>/dev/null || true
	@docker build -t quartusii:13.0sp1 \
	--build-arg user_uid=$$(id -u) \
	--build-arg user_gid=$$(id -g) \
	--build-arg user_name=$$(whoami) .
	@touch $@

.PHONY: clean
clean:
	docker rmi quartusii:13.0sp1 >&/dev/null || true
	rm -f container-image-built

