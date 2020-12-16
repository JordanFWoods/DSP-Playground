DISC_BFM_MK_LIB = $(DISC_BFM_OBJ)/makeobj.txt

# disc_bfm_lib bfm_pkg
$(DISC_BFM_OBJ)/bfm_pkg/_primary.dat : \
	$(DISC_BFM_SRC)/bfm_pkg.vhd \
	$(DISC_BFM_MK_LIB) \
	$(OSVVM_OBJ_DIR)/osvvmcontext/_primary.dat
	vcom -2008 -quiet -work disc_bfm_lib $<

# disc_bfm_lib actual BFM compile
$(DISC_BFM_OBJ)/disc_bfm/_primary.dat : \
	$(DISC_BFM_SRC)/disc_bfm.vhd \
	$(DISC_BFM_MK_LIB) \
	$(OSVVM_OBJ_DIR)/osvvmcontext/_primary.dat \
	$(DISC_BFM_OBJ)/bfm_pkg/_primary.dat
	vcom -2008 -quiet -work disc_bfm_lib $<

# Make the library directories, if needed.
$(DISC_BFM_MK_LIB) :
	vlib -type directory $(dir $@)
	@echo "This file was written and is managed by the Makefile. Do not alter / Delete" > $@

# Add a .rm suffix to the file name. This will make a phony target which will always cause the clean target to be executed
DISC_BFM_RM_LIB = $(addsuffix .rm,$(DISC_BFM_MK_LIB))

$(DISC_BFM_RM_LIB) : %.rm :
	rm -rf $(dir $@)