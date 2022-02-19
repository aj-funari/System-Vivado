`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2021 09:59:33 PM
// Design Name: 
// Module Name: saturating_counter_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module saturating_counter_tb;
    
    logic   clk;
	logic   rst;
	logic   enable;
	logic   up_down;  //1 for up, 0 for down
	logic   [1:0] count;
    
    saturating_counter sc0(
        .clk,
        .rst,
        .enable,
        .up_down,
        .count
        );
     
     task sc_test( input [1:0] count_test);
     
        assert( (count == count_test) )
            else $fatal(1, "%b %b %b %b", rst, enable, up_down, count);
     
     endtask
     
     always #5 clk = ~clk;
     
     initial begin
        clk = 0;
        rst = 1;
        enable = 0;
        up_down = 0;
        $monitor("clk:%b, rst:%b, enable:%b, up_down:%b", clk,rst,enable,up_down);
      
        for (int i = 0; i < 8; i++)
            @(negedge clk);
        
        $display(" stay at STATE_IDLE ");
        rst = 0; enable = 1; up_down = 0;
        @(negedge clk); sc_test(0);
        $display(" transition to STATE_ONE ");
        rst = 0; enable = 1; up_down = 1;
        @(negedge clk); sc_test(1);
        $display(" transition to STATE_TWO ");
        rst = 0; enable = 1; up_down = 1;
        @(negedge clk); sc_test(2);
        $display(" transistion to STATE_THREE ");
        rst = 0; enable = 1; up_down = 1;
        @(negedge clk); sc_test(3);
        $display( " stay at STATE_THREE ");
        rst = 0; enable = 1; up_down = 1;
        @(negedge clk); sc_test(3);
        $display (" transition to STATE_TWO ");
        rst = 0; enable = 1; up_down = 0;
        @(negedge clk); sc_test(2);
        $display (" transition to STATE_ONE ");
        rst = 0; enable = 1; up_down = 0;
        @(negedge clk); sc_test(1);
        $display (" transition to STATE_IDLE ");
        rst = 0; enable = 1; up_down = 0;
        @(negedge clk); sc_test(0);
        $display ("@@@PASSED!!!");
        $finish;
     end   
endmodule
