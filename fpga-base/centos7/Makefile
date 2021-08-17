all: container-image-built

container-image-built: Dockerfile
	@docker rmi fpga-base:centos7 &>/dev/null || true
	docker build -t fpga-base:centos7 .
	@touch $@

.PHONY: clean
clean:
	docker rmi fpga-base:centos7 >&/dev/null || true
	rm -f container-image-built
