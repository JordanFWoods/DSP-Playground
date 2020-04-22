set_location_assignment PIN_D9  -to max10_resetn
set_location_assignment PIN_J10 -to CLK_50

set_location_assignment PIN_C3 -to LED[0]
set_location_assignment PIN_C4 -to LED[1]
set_location_assignment PIN_C5 -to LED[2]
set_location_assignment PIN_D5 -to LED[3]
# set_location_assignment PIN_C7 -to LED[4]

set_location_assignment PIN_R20 -to PUSH_BTN[0]
set_location_assignment PIN_Y20 -to PUSH_BTN[1]
set_location_assignment PIN_Y21 -to PUSH_BTN[2]
set_location_assignment PIN_U20 -to PUSH_BTN[3]

set_location_assignment PIN_R18 -to DIP_SW[0]

set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to max10_resetn
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to CLK_50

set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED[3]
# set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to LED[4]

set_instance_assignment -name IO_STANDARD "1.2 V" -to PUSH_BTN[0]
set_instance_assignment -name IO_STANDARD "1.2 V" -to PUSH_BTN[1]
set_instance_assignment -name IO_STANDARD "1.2 V" -to PUSH_BTN[2]
set_instance_assignment -name IO_STANDARD "1.2 V" -to PUSH_BTN[3]

set_instance_assignment -name IO_STANDARD "1.2 V" -to DIP_SW[0]

# set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to drv_status_fail
# set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to drv_status_pass
# set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to drv_status_test_complete
# set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to global_reset_n
# set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to local_cal_fail
# set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to local_cal_success
# set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to pll_ref_clk
# set_instance_assignment -name IO_STANDARD "1.5 V" -to local_init_done
# set_location_assignment PIN_D5 -to drv_status_fail
# set_location_assignment PIN_C5 -to drv_status_pass
# set_location_assignment PIN_C7 -to drv_status_test_complete
# set_location_assignment PIN_D9 -to global_reset_n
# set_location_assignment PIN_C4 -to local_cal_fail
# set_location_assignment PIN_C3 -to local_cal_success
# set_instance_assignment -name IO_STANDARD "1.5 V" -to soft_reset_n
