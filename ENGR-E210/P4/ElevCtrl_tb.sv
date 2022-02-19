`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2021 08:42:03 PM
// Design Name: 
// Module Name: ElevCtrl_tb
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


module ElevCtrl_tb();
    logic        clk; //clock
    logic        rst; //reset
    logic [3:0]  floorBtn; //signal to send

    logic [1:0] floorSel;
    logic       door;

ElevCtrl ElevCtrl0 (
    .clk,
    .rst,
    .floorBtn,
    .floorSel,
    .door
);

task Elev_Test;
input [1:0] floorSelT;
input doorT;

assert((floorSel == floorSelT) && (door == doorT))
            else $fatal(1,"ElevCtrl(%b,&b), failed!", floorSel, door);
            
endtask    

always #5 clk = ~clk;

initial
begin
clk = 0;
rst = 1;
floorBtn = 4'b0000;

    $monitor("clk:%b, rst:%b, floorBtn:%b, door:%b", clk, floorBtn, floorSel, door);
    
    for (int i = 0; i < 8; ++i)
        @(negedge clk);
        
    $display("State 1 Door Open");
    rst = 0; floorBtn = 4'b0001;
    @(negedge clk);   
    Elev_Test(00, 1);
    
    $display("State 1 Door Close");
    floorBtn = 4'b0010;
    @(negedge clk);
    Elev_Test(00, 0);
    
    $display("State 2 Door Close");
    floorBtn = 4'b0010;
    @(negedge clk);
    Elev_Test(01, 0);
    
    $display("State 2 Door Open");
    floorBtn = 4'b0010;
    @(negedge clk);
    Elev_Test(01, 1);
    
    $display("State 2 Door Close");
    floorBtn = 4'b0100;
    @(negedge clk);
    Elev_Test(01, 0);
    
    $display("State 3 Door Close");
    floorBtn = 4'b0100;
    @(negedge clk);
    Elev_Test(10, 0);
    
    $display("State 3 Door Open");
    floorBtn = 4'b0100;
    @(negedge clk);
    Elev_Test(10, 1);
    
    $display("State 3 Door Close");
    floorBtn = 4'b1000;
    @(negedge clk);
    Elev_Test(10, 0);
    
    $display("State 4 Door Close");
    floorBtn = 4'b1000;
    @(negedge clk);
    Elev_Test(11, 0);
    
    $display("State 4 Door Open");
    floorBtn = 4'b1000;
    @(negedge clk);
    Elev_Test(11, 1);
    
    $display("State 4 Door Close");
    floorBtn = 4'b0100;
    @(negedge clk);
    Elev_Test(11, 0);
    
    $display("State 3 Door Close");
    floorBtn = 4'b0100;
    @(negedge clk);
    Elev_Test(10, 0);
    
    $display("State 3 Door Open");
    floorBtn = 4'b0100;
    @(negedge clk);
    Elev_Test(10, 1);
    
    $display("State 3 Door Close");
    floorBtn = 4'b0010;
    @(negedge clk);
    Elev_Test(10, 0);
    
    $display("State 2 Door Close");
    floorBtn = 4'b0010;
    @(negedge clk);
    Elev_Test(01, 0);
    
    $display("State 2 Door Open");
    floorBtn = 4'b0010;
    @(negedge clk);
    Elev_Test(01, 1);
    
    $display("State 2 Door Close");
    floorBtn = 4'b0001;
    @(negedge clk);
    Elev_Test(01, 0);
    
    $display("State 1 Door Close");
    floorBtn = 4'b0001;
    @(negedge clk);
    Elev_Test(00, 0);
    
    $display("State 1 Door Open");
    rst = 0; floorBtn = 4'b0001;
    @(negedge clk);   
    Elev_Test(00, 1);
    
    $display("Reset");
    rst = 1; floorBtn = 4'b0000;
    @(negedge clk);
    Elev_Test(00, 1);
            
    $display("@@@Passed");
    $finish;
end    
endmodule