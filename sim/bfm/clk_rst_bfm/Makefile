################################################
## Proprietary Property of:
##
## Jordan Woods
## 312 Calle Bonita
## Escondido CA, 92029
##
################################################
## Title: Makefile for clk_rst_bfm
##
## File Name: Makefile
##
## Author: jordan
##
## Description: This is the Makefile associated
##              with the clk_rst_bfm. It
##              currently compiles the library
##              from start to finish.
##
################################################
## Manual Revision History:
## 12/16/20 - JFW - Initial Check In.


##### Setting up and cleaning the directory ####

CLK_RST_MK_LIB = $(CLK_RST_OBJ)/makeobj.txt

# Make the library directories, if needed.
$(CLK_RST_MK_LIB) :
	vlib -type directory $(dir $@)
	@echo "This file was written and is managed by the Makefile. Do not alter / delete" > $@

# Add a .rm suffix to the file name. This will make a phony target which will always cause the clean target to be executed
CLK_RST_RM_LIB = $(addsuffix .rm,$(CLK_RST_MK_LIB))

$(CLK_RST_RM_LIB) : %.rm :
	rm -rf $(dir $@)

##### The actual compile dependencies ####

# clk_rst_lib library
$(CLK_RST_OBJ)/clk_rst_bfm/_primary.dat : \
	$(CLK_RST_SRC)/clk_rst_bfm.vhd \
	$(CLK_RST_MK_LIB) \
	$(OSVVM_OBJ_DIR)/osvvmcontext/_primary.dat
	vcom $(CLK_VCOM_OPT) $<