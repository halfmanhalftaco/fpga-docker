INSTALLER=Quartus-web-13.1.0.162-linux.tar
UPDATE=QuartusSetup-13.1.4.182.run
INSTALLER_CHECKSUM=BA705F9D15F3A43AB7E86D297F394EE3
UPDATE_CHECKSUM=172C8CD0EB631B988516F1182054F976

FILES=$(INSTALLER) $(UPDATE) Dockerfile

all: container-image-built

${INSTALLER}:
	curl -O http://download.altera.com/akdlm/software/acdsinst/13.1/162/ib_tar/Quartus-web-13.1.0.162-linux.tar
	@SUM=$$(md5sum $(INSTALLER) | awk '{print toupper($$1)}'); \
        if [ "$$SUM" != "$(INSTALLER_CHECKSUM)" ]; then echo "Installer checksum doesn't match."; exit 1; fi
	
${UPDATE}:
	curl -O http://download.altera.com/akdlm/software/acdsinst/13.1.4/182/update/QuartusSetup-13.1.4.182.run
	@SUM=$$(md5sum $(UPDATE) | awk '{print toupper($$1)}'); \
        if [ "$$SUM" != "$(UPDATE_CHECKSUM)" ]; then echo "Updater checksum doesn't match."; exit 1; fi	

container-image-built: $(FILES)
	@docker rmi quartusii:13.1 &>/dev/null || true
	@docker build -t quartusii:13.1 . \
	--build-arg user_uid=$$(id -u) --build-arg user_gid=$$(id -g) \
	--build-arg user_name=$$(whoami)
	@touch $@

.PHONY: clean
clean:
	docker rmi quartusii:13.1 >&/dev/null || true
	rm -f container-image-built

