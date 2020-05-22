INSTALLER=Quartus-lite-18.1.0.625-linux.tar
CHECKSUM=EAF82392603B92DAE632CC0F356B08AA

FILES=$(INSTALLER) Dockerfile

all: container-image-built

${INSTALLER}:
	curl -O http://download.altera.com/akdlm/software/acdsinst/18.1std/625/ib_tar/Quartus-lite-18.1.0.625-linux.tar
	@SUM=$$(md5sum $(INSTALLER) | awk '{print toupper($$1)}'); \
	  if [ "$$SUM" != "$(CHECKSUM)" ]; then echo "Checksum doesn't match."; exit 1; fi

container-image-built: $(FILES)
	@docker rmi quartus:18.1 &>/dev/null || true
	docker build -t quartus:18.1 . \
        --build-arg user_uid=$$(id -u) \
        --build-arg user_gid=$$(id -g) \
        --build-arg user_name=$$(whoami)
	touch $@

.PHONY: clean
clean:
	docker rmi quartus:18.1 >&/dev/null || true
	rm -f container-image-built