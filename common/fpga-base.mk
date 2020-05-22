.PHONY: fpga-base
fpga-base:
	@docker image inspect fpga-base &>/dev/null || \
		(echo "fpga-base image does not exist"; exit 1 )

