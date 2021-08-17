INSTALLER=Xilinx_ISE_14.7_Win10_14.7_VM_0213_1.zip
VMDISK=14.7_VM-disk001.vmdk
FILES=build/Dockerfile $(INSTALLER) $(VMDISK) install/install.sh install/launch.sh

all: container-image-built

${INSTALLER}:
	@echo "Download installer from Xilinx. See README.md"
	@exit 1

.INTERMEDIATE: $(VMDISK)
build/$(VMDISK): $(INSTALLER)
	unzip -p $(INSTALLER) ova/14.7_VM.ova | tar xf - ${VMDISK} -O > $@ 

container-image-built: $(FILES)
	@docker rm ise-install &>/dev/null || true
	@docker rmi ise:14.7 ise-install:latest &>/dev/null || true
	mkdir -p $(CURDIR)/install/mnt
	sudo modprobe nbd
	sudo qemu-nbd -c /dev/nbd0 -r $(VMDISK)
	@while [ ! -b /dev/nbd0p1 ]; do echo "Waiting for /dev/nbd0p1..."; sleep 2; done
	sudo mount -o ro /dev/nbd0p1 $(CURDIR)/install/mnt
	docker run --name ise-install -v $(CURDIR)/install:/build \
	  -i --entrypoint /bin/bash fpga-base:centos6 /build/install.sh
	docker commit ise-install ise-install
	docker build -t ise:14.7 ./build
	docker rm ise-install
	docker rmi ise-install
	sudo umount /dev/nbd0p1
	sudo qemu-nbd -d /dev/nbd0
	rmdir $(CURDIR)/install/mnt
	@touch $@

.PHONY: clean
clean:
	docker rm ise-install &>/dev/null || true
	docker rmi ise-install:latest ise:14.7 &>/dev/null || true
	sudo umount /dev/nbd0p1 >&/dev/null || true
	sudo qemu-nbd -d /dev/nbd0 >&/dev/null || true
	rm -f container-image-built
