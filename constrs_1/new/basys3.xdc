## 系统时钟 (100MHz)
set_property PACKAGE_PIN W5 [get_ports i_top_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_top_clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports i_top_clk]

## 用户交互 (按键与 LED)
set_property PACKAGE_PIN T18 [get_ports i_top_rst]               
set_property IOSTANDARD LVCMOS33 [get_ports i_top_rst]
set_property PACKAGE_PIN W19 [get_ports i_top_cam_start]         
set_property IOSTANDARD LVCMOS33 [get_ports i_top_cam_start]
set_property PACKAGE_PIN T17 [get_ports i_top_inc_sobel_thresh]  
set_property IOSTANDARD LVCMOS33 [get_ports i_top_inc_sobel_thresh]
set_property PACKAGE_PIN U17 [get_ports i_top_dec_sobel_thresh]  
set_property IOSTANDARD LVCMOS33 [get_ports i_top_dec_sobel_thresh]
set_property PACKAGE_PIN U16 [get_ports o_top_cam_done]
set_property IOSTANDARD LVCMOS33 [get_ports o_top_cam_done]

## VGA 接口
set_property PACKAGE_PIN G19 [get_ports {o_top_vga_red[0]}]
set_property PACKAGE_PIN H19 [get_ports {o_top_vga_red[1]}]
set_property PACKAGE_PIN J19 [get_ports {o_top_vga_red[2]}]
set_property PACKAGE_PIN N19 [get_ports {o_top_vga_red[3]}]
set_property PACKAGE_PIN J17 [get_ports {o_top_vga_green[0]}]
set_property PACKAGE_PIN H17 [get_ports {o_top_vga_green[1]}]
set_property PACKAGE_PIN G17 [get_ports {o_top_vga_green[2]}]
set_property PACKAGE_PIN D17 [get_ports {o_top_vga_green[3]}]
set_property PACKAGE_PIN N18 [get_ports {o_top_vga_blue[0]}]
set_property PACKAGE_PIN L18 [get_ports {o_top_vga_blue[1]}]
set_property PACKAGE_PIN K18 [get_ports {o_top_vga_blue[2]}]
set_property PACKAGE_PIN J18 [get_ports {o_top_vga_blue[3]}]
set_property PACKAGE_PIN P19 [get_ports o_top_vga_hsync]
set_property PACKAGE_PIN R19 [get_ports o_top_vga_vsync]
set_property IOSTANDARD LVCMOS33 [get_ports o_top_vga_red*]
set_property IOSTANDARD LVCMOS33 [get_ports o_top_vga_green*]
set_property IOSTANDARD LVCMOS33 [get_ports o_top_vga_blue*]
set_property IOSTANDARD LVCMOS33 [get_ports o_top_vga_hsync]
set_property IOSTANDARD LVCMOS33 [get_ports o_top_vga_vsync]

## 摄像头接口 - 重新分配到 JB 和 JC
## JC 接口 (负责 D0-D5 和 PWDN/RESET)
set_property PACKAGE_PIN K17 [get_ports o_top_pwdn]             ; # JC1
set_property PACKAGE_PIN M18 [get_ports {i_top_pix_byte[0]}]    ; # JC2
set_property PACKAGE_PIN N17 [get_ports {i_top_pix_byte[2]}]    ; # JC3
set_property PACKAGE_PIN P18 [get_ports {i_top_pix_byte[4]}]    ; # JC4
set_property PACKAGE_PIN L17 [get_ports o_top_reset]            ; # JC7
set_property PACKAGE_PIN M19 [get_ports {i_top_pix_byte[1]}]    ; # JC8
set_property PACKAGE_PIN P17 [get_ports {i_top_pix_byte[3]}]    ; # JC9
set_property PACKAGE_PIN R18 [get_ports {i_top_pix_byte[5]}]    ; # JC10

## JB 接口 (负责 D6-D7 和 时序信号/I2C)
set_property PACKAGE_PIN A14 [get_ports {i_top_pix_byte[6]}]    ; # JB1
set_property PACKAGE_PIN A16 [get_ports o_top_xclk]             ; # JB2
set_property PACKAGE_PIN B15 [get_ports i_top_pix_href]         ; # JB3
set_property PACKAGE_PIN B16 [get_ports o_top_siod]             ; # JB4
set_property PACKAGE_PIN A15 [get_ports {i_top_pix_byte[7]}]    ; # JB7
set_property PACKAGE_PIN A17 [get_ports i_top_pix_vsync]        ; # JB8
set_property PACKAGE_PIN C15 [get_ports o_top_sioc]             ; # JB9
set_property PACKAGE_PIN C16 [get_ports i_top_pclk]             ; # JB10

## 电气属性设置
set_property IOSTANDARD LVCMOS33 [get_ports -filter {NAME =~ *top_pwdn*}]
set_property IOSTANDARD LVCMOS33 [get_ports -filter {NAME =~ *top_reset*}]
set_property IOSTANDARD LVCMOS33 [get_ports -filter {NAME =~ *top_xclk*}]
set_property IOSTANDARD LVCMOS33 [get_ports -filter {NAME =~ *top_siod*}]
set_property IOSTANDARD LVCMOS33 [get_ports -filter {NAME =~ *top_sioc*}]
set_property IOSTANDARD LVCMOS33 [get_ports -filter {NAME =~ *top_pclk*}]
set_property IOSTANDARD LVCMOS33 [get_ports -filter {NAME =~ *top_pix*}]

## 允许摄像头时钟走普通布线 (PCLK 报错解决方案)
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets i_top_pclk_IBUF]