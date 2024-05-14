# Constraints for 8-bit Counter on Basys 3 FPGA

#Clock assignment
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Reset pin assignment
set_property PACKAGE_PIN U16 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]



set_property PACKAGE_PIN V13 [get_ports { out[0] }]; 					
set_property IOSTANDARD LVCMOS33 [get_ports { out[0] }];

set_property PACKAGE_PIN V3 [get_ports { out[1] }]; 					
set_property IOSTANDARD LVCMOS33 [get_ports { out[1] }];

set_property PACKAGE_PIN W3 [get_ports { out[2] }]; 					
set_property IOSTANDARD LVCMOS33 [get_ports { out[2] }];

set_property PACKAGE_PIN U3 [get_ports { out[3] }]; 					
set_property IOSTANDARD LVCMOS33 [get_ports { out[3] }];

set_property PACKAGE_PIN P3 [get_ports { out[4] }]; 					
set_property IOSTANDARD LVCMOS33 [get_ports { out[4] }];

set_property PACKAGE_PIN N3 [get_ports { out[5] }]; 					
set_property IOSTANDARD LVCMOS33 [get_ports { out[5] }];

set_property PACKAGE_PIN P1 [get_ports { out[6] }]; 					
set_property IOSTANDARD LVCMOS33 [get_ports { out[6] }];

set_property PACKAGE_PIN L1 [get_ports { out[7] }]; 					
set_property IOSTANDARD LVCMOS33 [get_ports { out[7] }];
