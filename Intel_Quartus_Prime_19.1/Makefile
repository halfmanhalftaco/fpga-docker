INSTALLER=Quartus-lite-19.1.0.670-linux.tar
CHECKSUM=EA13279A52D174A4E987E5379954B4DE

FILES=$(INSTALLER) Dockerfile

all: container-image-built

${INSTALLER}:
	curl -O data: http://download.altera.com/akdlm/software/acdsinst/19.1std/670/ib_tar/Quartus-lite-19.1.0.670-linux.tar
	@SUM=$$(md5sum $(INSTALLER) | awk '{print toupper($$1)}'); \
		if [ "$$SUM" != "$(CHECKSUM)" ]; then echo "Checksum doesn't match."; exit 1; fi

container-image-built: $(FILES)
	@docker rmi quartusii:19.1 &>/dev/null || true
	docker build -t quartus:19.1 . \
        --build-arg user_uid=$$(id -u) \
        --build-arg user_gid=$$(id -g) \
        --build-arg user_name=$$(whoami)
	@touch $@

.PHONY: clean
clean:
	docker rmi quartus:19.1 >&/dev/null || true
	rm -f container-image-built
