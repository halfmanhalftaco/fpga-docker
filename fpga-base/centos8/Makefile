TAG=fpga-base:centos8

all: container-image-built

container-image-built: Dockerfile
	@docker rmi $(TAG) &>/dev/null || true
	docker build --rm -t $(TAG) .
	@touch $@

.PHONY: clean
clean:
	docker rmi $(TAG) >&/dev/null || true
	rm -f container-image-built
