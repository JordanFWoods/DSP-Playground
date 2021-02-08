################################################
## Proprietary Property of:
##
## Jordan Woods
## 312 Calle Bonita
## Escondido CA, 92029
##
################################################
## Title: Makefile for disc_bfm
##
## File Name: Makefile
##
## Author: jordan
##
## Description: This is the Makefile associated
##              with the disc_bfm. It
##              currently compiles the library
##              from start to finish.
##
################################################
## Manual Revision History:
## 12/16/20 - JFW - Initial Check In.


##### Setting up and cleaning the directory ####

DISC_BFM_MK_LIB = $(DISC_BFM_OBJ)/makeobj.txt

# Make the library directories, if needed.
$(DISC_BFM_MK_LIB) :
	vlib -type directory $(dir $@)
	@echo "This file was written and is managed by the Makefile. Do not alter / Delete" > $@
	vmap -quiet $(patsubst $(lib)/%/, %, $(dir $@)) $(dir $@)

# Add a .rm suffix to the file name. This will make a phony target which will always cause the clean target to be executed
DISC_BFM_RM_LIB = $(addsuffix .rm,$(DISC_BFM_MK_LIB))

$(DISC_BFM_RM_LIB) : %.rm :
	rm -rf $(dir $@)

##### The actual compile dependencies ####

# disc_bfm_lib bfm_pkg
$(DISC_BFM_OBJ)/bfm_pkg/_primary.dat : \
	$(DISC_BFM_SRC)/bfm_pkg.vhd \
	$(DISC_BFM_MK_LIB) \
	$(OSVVM_OBJ_DIR)/osvvmcontext/_primary.dat
	vcom $(DISC_VCOM_OPT) $<

# disc_bfm_lib actual BFM compile
$(DISC_BFM_OBJ)/disc_bfm/_primary.dat : \
	$(DISC_BFM_SRC)/disc_bfm.vhd \
	$(DISC_BFM_MK_LIB) \
	$(OSVVM_OBJ_DIR)/osvvmcontext/_primary.dat \
	$(DISC_BFM_OBJ)/bfm_pkg/_primary.dat
	vcom $(DISC_VCOM_OPT) $<
