CLK_RST_MK_LIB = $(CLK_RST_OBJ)/makeobj.txt

# clk_rst_lib library
$(CLK_RST_OBJ)/clk_rst_bfm/_primary.dat : \
	$(CLK_RST_SRC)/clk_rst_bfm.vhd \
	$(CLK_RST_MK_LIB) \
	$(OSVVM_OBJ_DIR)/osvvmcontext/_primary.dat
	vcom -2008 -quiet -work sim_lib $<

# Make the library directories, if needed.
$(CLK_RST_MK_LIB) :
	vlib -type directory $(dir $@)
	@echo "This file was written and is managed by the Makefile. Do not alter / delete" > $@

# Add a .rm suffix to the file name. This will make a phony target which will always cause the clean target to be executed
CLK_RST_RM_LIB = $(addsuffix .rm,$(CLK_RST_MK_LIB))

$(CLK_RST_RM_LIB) : %.rm :
	rm -rf $(dir $@)