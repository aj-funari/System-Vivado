`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2021 08:42:46 PM
// Design Name: 
// Module Name: SevSegDisplay_tb
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


module SevSegDisplay_tb();
    logic [1:0] floorSel;
    logic door;
    logic [6:0] segments;
    logic [3:0] select;

SevSegDisplay SSD0 (
    .floorSel,
    .door,
    .segments,
    .select
);    

task SSD_Test;
    input [1:0] floorSelT;
    input doorT;
    input [6:0] segmentsT;
    input [3:0] selectT;
    
    #5
    floorSel = floorSelT; door = doorT;
    #5
    assert( (segments == segmentsT) && (select == selectT) ) 
        else $fatal(1,"SevSegDisplay_test(%b,%b) failed!", segments, select);

endtask

initial begin
    floorSel = 2'b00;
    door = 0;
    #10
    
    $monitor("segments:%b, select:%b", segments, select);

    SSD_Test('b00,'b1, 'b1000011,'b1110);
    SSD_Test('b00,'b0, 'b0100011,'b1110);
    SSD_Test('b01,'b1, 'b1000011,'b1101);
    SSD_Test('b01,'b0, 'b0100011,'b1101);
    SSD_Test('b10,'b1, 'b1000011,'b1011);
    SSD_Test('b10,'b0, 'b0100011,'b1011);
    SSD_Test('b11,'b1, 'b1000011,'b0111);
    SSD_Test('b11,'b0, 'b0100011,'b0111);
        
    $display("@@@Passed");
    $finish;
end
endmodule
