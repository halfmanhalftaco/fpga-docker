TAG=ubuntu-bionic

all: container-image-built

container-image-built: Dockerfile
	@docker rmi fpga-base:$(TAG) &>/dev/null || true
	docker build -t fpga-base:$(TAG) .
	@touch $@

.PHONY: clean
clean:
	docker rmi fpga-base:$(TAG) >&/dev/null || true
	rm -f container-image-built
