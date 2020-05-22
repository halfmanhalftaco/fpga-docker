all: container-image-built

container-image-built: Dockerfile
	@docker rmi fpga-base &>/dev/null || true
	docker build -t fpga-base .
	@touch $@

.PHONY: clean
clean:
	docker rmi fpga-base >&/dev/null || true
	rm -f container-image-built