all: container-image-built
TAG=centos6

container-image-built: Dockerfile fpga
	@docker rmi fpga-base:$(TAG) &>/dev/null || true
	docker build -t fpga-base:$(TAG) .
	@touch $@

.PHONY: clean
clean:
	docker rmi fpga-base:$(TAG) >&/dev/null || true
	rm -f container-image-built
