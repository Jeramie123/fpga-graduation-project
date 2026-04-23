`timescale 1ns / 1ps
`default_nettype none 

/*
 *  Uses X,Y pixel counters from VGA driver
 *  to form an address generator to read from BRAM; output
 *  RGB pixel data from BRAM during active video region;  
 *  wraps VGA sync pulses 
 *
 *  NOTE:  
 *  
 *  - Address generator only increments when
 *      1. Two complete VGA frames passed since reset
 *      2. Current posedge of VGA clock is a valid video pixel position
 *      3. Next posedge of VGA clock is a valid video pixel position
 *  
 *  - Address generator set to 0 in either circumstance
 *      1. Address to BRAM reaches 307199 (x = 640, y = 479)
 *      2. Next posedge of VGA clock is NOT valid video  
 *
 */

module vga_top
    (   input wire          i_clk25m,
        input wire          i_rstn_clk25m,
        
        // VGA driver signals
        output wire [9:0]   o_VGA_x,
        output wire [9:0]   o_VGA_y, 
        output wire         o_VGA_vsync,
        output wire         o_VGA_hsync, 
        output wire         o_VGA_video,
        output reg  [3:0]   o_VGA_r,
        output reg  [3:0]   o_VGA_g,
        output reg  [3:0]   o_VGA_b, 
        
        // VGA read from BRAM 
        input  wire [7:0]  i_pix_data, 
        output reg  [18:0] o_pix_addr
    );
    
    vga_driver
    #(  .hDisp(640              ), 
        .hFp(16                 ), 
        .hPulse(96              ), 
        .hBp(48                 ), 
        .vDisp(480              ), 
        .vFp(10                 ), 
        .vPulse(2               ),
        .vBp(33)                )
    vga_timing_signals
    (   .i_clk(i_clk25m         ),
        .i_rstn(i_rstn_clk25m   ),
        
        // VGA timing signals
        .o_x_counter(o_VGA_x    ),
        .o_y_counter(o_VGA_y    ),
        .o_video(o_VGA_video    ), 
        .o_vsync(o_VGA_vsync    ),
        .o_hsync(o_VGA_hsync    )
    );
    
// ----------------------------------------------------
    // 新增：320x240 等比例放大至 640x480 的显示寻址逻辑
    // ----------------------------------------------------
    // 将当前的屏幕物理坐标除以 2 (即右移 1 位)，实现长宽各放大 2 倍
    wire [8:0] image_x = o_VGA_x[9:1]; 
    wire [7:0] image_y = o_VGA_y[9:1]; 

    always @(posedge i_clk25m or negedge i_rstn_clk25m) begin
        if (!i_rstn_clk25m) begin
            o_pix_addr <= 0;
        end else if ((o_VGA_x < 640) && (o_VGA_y < 480)) begin
            // 内存地址 = 图像Y坐标 * 320 + 图像X坐标
            o_pix_addr <= image_y * 320 + image_x;
        end else begin
            o_pix_addr <= 0;
        end
    end
    

    always @(*)
        begin
            if(o_VGA_video)
                begin
                    o_VGA_r = (i_pix_data[3:0]); 
                    o_VGA_g = (i_pix_data[3:0]);
                    o_VGA_b = (i_pix_data[3:0]);
                end
            else begin
                    o_VGA_r = 0; 
                    o_VGA_g = 0;
                    o_VGA_b = 0;
            end
        end 
    
endmodule
