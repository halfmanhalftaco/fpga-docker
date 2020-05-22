INSTALLER=Xilinx_ISE_14.7_Win10_14.7_VM_0213_1.zip
VMDISK=14.7_VM-disk001.vmdk
FILES=build/Dockerfile $(INSTALLER) build/$(VMDISK) build/launch.sh

all: container-image-built

${INSTALLER}:
	@echo "Download installer from Xilinx. See README.md"
	@exit 1

.INTERMEDIATE: build/$(VMDISK)
build/$(VMDISK): $(INSTALLER)
	unzip -p $(INSTALLER) ova/14.7_VM.ova | tar xf - ${VMDISK} -O > $@ 

container-image-built: $(FILES)
	@docker rm ise-install &>/dev/null || true
	@docker rmi ise:14.7 ise-install:14.7 &>/dev/null || true
	mkdir -p $(CURDIR)/build/mnt
	sudo modprobe nbd
	sudo qemu-nbd -c /dev/nbd0 -r $(CURDIR)/build/$(VMDISK)
	@while [ ! -b /dev/nbd0p1 ]; do echo "Waiting for /dev/nbd0p1..."; sleep 2; done
	sudo mount -o ro /dev/nbd0p1 $(CURDIR)/build/mnt
	docker run --name ise-install -v $(CURDIR)/build/mnt:/mnt \
	  -i fpga-base /bin/bash < build/install.sh
	docker commit ise-install ise-install:14.7
	docker rm ise-install
	sudo umount /dev/nbd0p1
	sudo qemu-nbd -d /dev/nbd0
	rmdir $(CURDIR)/build/mnt
	@docker build ./build -t ise:14.7 \
	  --build-arg user_uid=$$(id -u) \
	  --build-arg user_gid=$$(id -g) \
	  --build-arg user_name=$$(whoami)
	@touch $@

.PHONY: clean
clean:
	docker rm ise-install &>/dev/null || true
	docker rmi ise-install:14.7 ise:14.7 &>/dev/null || true
	sudo umount /dev/nbd0p1 >&/dev/null || true
	sudo qemu-nbd -d /dev/nbd0 >&/dev/null || true
	rm -f container-image-built
