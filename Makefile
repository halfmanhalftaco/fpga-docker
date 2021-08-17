# Comment out the ones you don't want.

#TOOLS += Altera_Quartus_II_13.0sp1
#TOOLS += Altera_Quartus_II_13.1
#TOOLS += Altera_Quartus_II_14.0
#TOOLS += Altera_Quartus_II_14.1
#TOOLS += Altera_Quartus_II_15.0
#TOOLS += Altera_Quartus_Prime_15.1
#TOOLS += Altera_Quartus_Prime_16.0
#TOOLS += Altera_Quartus_Prime_16.1
#TOOLS += Altera_Quartus_Prime_17.0
#TOOLS += Altera_Quartus_Prime_17.1
#TOOLS += Intel_Quartus_Prime_18.0
#TOOLS += Intel_Quartus_Prime_18.1
#TOOLS += Intel_Quartus_Prime_19.1
#TOOLS += Intel_Quartus_Prime_10.1
#TOOLS += Intel_Quartus_Prime_20.1.1
#TOOLS += Lattice_iCEcube2
#TOOLS += Xilinx_ISE_14.7

DIRS=fpga-base/centos6 $(TOOLS)

ALLDIRS=Altera* Intel* Lattice* Xilinx* fpga-base/*
# ALLDIRS=Altera_Quartus_II_13.0sp1 Altera_Quartus_II_13.1
# ALLDIRS+=Altera_Quartus_II_14.0 Altera_Quartus_II_14.1 
# ALLDIRS+=Altera_Quartus_Prime_17.0 Intel_Quartus_Prime_18.1
# ALLDIRS+=Intel_Quartus_Prime_19.1 Intel_Quartus_Prime_20.1.1
# ALLDIRS+=Lattice_iCEcube2 Xilinx_ISE_14.7 fpga-base/centos6

all: $(DIRS)

.PHONY: $(DIRS)
$(DIRS):
	@make -C $@

clean:
	@for dir in $(ALLDIRS); do \
		make -C $$dir clean; \
	done
	docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.temp" -q)
	docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.tool" -q)
	docker rmi $$(docker images --filter "label=com.halfmanhalftaco.fpga.base" -q)
