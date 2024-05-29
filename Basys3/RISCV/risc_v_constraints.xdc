## Clock signal
set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
#create_clock -add -name clk -period 10.00 -waveform {0 5} [get_ports {clk}]

## LEDs for visual feedback on operations
set_property PACKAGE_PIN U16 [get_ports leds[0]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[0]]
set_property PACKAGE_PIN E19 [get_ports leds[1]]
set_property IOSTANDARD LVCMOS33 [get_ports leds[1]]
set_property PACKAGE_PIN U19 [get_ports leds[2]]
set_property IOSTANDARD LVCMOS33 [get_ports leds[2]]
set_property PACKAGE_PIN V19 [get_ports leds[3]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[3]]
set_property PACKAGE_PIN W18 [get_ports leds[4]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[4]]
set_property PACKAGE_PIN U15 [get_ports leds[5]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[5]]
set_property PACKAGE_PIN U14 [get_ports leds[6]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[6]]
set_property PACKAGE_PIN V14 [get_ports leds[7]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[7]]
set_property PACKAGE_PIN V13 [get_ports leds[8]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[8]]
set_property PACKAGE_PIN V3 [get_ports leds[9]]
set_property IOSTANDARD LVCMOS33 [get_ports leds[9]]
set_property PACKAGE_PIN W3 [get_ports leds[10]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[10]]
set_property PACKAGE_PIN U3 [get_ports leds[11]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[11]]
set_property PACKAGE_PIN P3 [get_ports leds[12]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[12]]
set_property PACKAGE_PIN N3 [get_ports leds[13]]
set_property IOSTANDARD LVCMOS33 [get_ports leds[13]]
set_property PACKAGE_PIN P1 [get_ports leds[14]] 
set_property IOSTANDARD LVCMOS33 [get_ports leds[14]]
set_property PACKAGE_PIN L1 [get_ports leds[15]]
set_property IOSTANDARD LVCMOS33 [get_ports leds[15]]

## 7-segment display segments
set_property PACKAGE_PIN W7 [get_ports seg[0]] 
set_property IOSTANDARD LVCMOS33 [get_ports seg[0]]
set_property PACKAGE_PIN W6 [get_ports seg[1]] 
set_property IOSTANDARD LVCMOS33 [get_ports seg[1]]
set_property PACKAGE_PIN U8 [get_ports seg[2]] 
set_property IOSTANDARD LVCMOS33 [get_ports seg[2]]
set_property PACKAGE_PIN V8 [get_ports seg[3]] 
set_property IOSTANDARD LVCMOS33 [get_ports seg[3]]
set_property PACKAGE_PIN U5 [get_ports seg[4]]
set_property IOSTANDARD LVCMOS33 [get_ports seg[4]]
set_property PACKAGE_PIN V5 [get_ports seg[5]] 
set_property IOSTANDARD LVCMOS33 [get_ports seg[5]]
set_property PACKAGE_PIN U7 [get_ports seg[6]] 
set_property IOSTANDARD LVCMOS33 [get_ports seg[6]]
#set_property PACKAGE_PIN U10 [get_ports seg_dp] 
#set_property IOSTANDARD LVCMOS33 [get_ports seg_dp]

## 7-segment display anodes (digits)
set_property PACKAGE_PIN W4 [get_ports an[3]]
set_property IOSTANDARD LVCMOS33 [get_ports an[3]]
set_property PACKAGE_PIN V4 [get_ports an[2]] 
set_property IOSTANDARD LVCMOS33 [get_ports an[2]]
set_property PACKAGE_PIN U4 [get_ports an[1]] 
set_property IOSTANDARD LVCMOS33 [get_ports an[1]]
set_property PACKAGE_PIN U2 [get_ports an[0]] 
set_property IOSTANDARD LVCMOS33 [get_ports an[0]]

## Additional signals (example for buttons or other controls)
set_property PACKAGE_PIN U18 [get_ports btn_reset] 
set_property IOSTANDARD LVCMOS33 [get_ports btn_reset]

## Force Vivado to recognize constraints (for testing purposes)
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]