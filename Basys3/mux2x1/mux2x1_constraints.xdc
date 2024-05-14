# Constraints for 2x1 MUX on Basys 3 FPGA

# Switches
set_property PACKAGE_PIN W15 [get_ports { input_1 }];					
set_property IOSTANDARD LVCMOS33 [get_ports { input_1 }];

set_property PACKAGE_PIN V15 [get_ports { input_2 }];					
set_property IOSTANDARD LVCMOS33 [get_ports { input_2 }];

set_property PACKAGE_PIN U15 [get_ports { select_line }];					
set_property IOSTANDARD LVCMOS33 [get_ports { select_line }];

# LED output
set_property PACKAGE_PIN U16 [get_ports { output_led }];					
set_property IOSTANDARD LVCMOS33 [get_ports { output_led }];