# Comment out the ones you don't want.
TOOLS += Altera_Quartus_II_13.0sp1
TOOLS += Altera_Quartus_II_13.1
TOOLS += Intel_Quartus_Prime_18.1
TOOLS += Intel_Quartus_Prime_19.1
TOOLS += Lattice_iCEcube2
TOOLS += Xilinx_ISE_14.7

DIRS=common $(TOOLS)
ALLDIRS=Altera_Quartus_II_13.0sp1 Altera_Quartus_II_13.1
ALLDIRS+=Altera_Quartus_II_13.1 Intel_Quartus_Prime_18.1
ALLDIRS+=Lattice_iCEcube2 Xilinx_ISE_14.7 common

all: $(DIRS)

.PHONY: $(DIRS)

$(TOOLS): common
	@make -C $@

common:
	@make -C $@

clean:
	@for dir in $(ALLDIRS); do \
		make -C $$dir clean; \
	done
