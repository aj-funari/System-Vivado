`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2021 07:35:00 PM
// Design Name: 
// Module Name: SevSegDisplay
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


module SevSegDisplay(
    input   [1:0] floorSel,
    input         door, 

    output logic [6:0] segments,  
    output logic [3:0] select  
);

//active low
//open = 1000011
//close = 0100011

always_comb begin

if (floorSel == 2'b00) begin
    select = 4'b1110;
    if (door == 1'h1) begin
        segments = 7'b1000011; end 
    else if (door == 1'h0) begin
        segments = 7'b0100011; end end
        
if (floorSel == 2'b01) begin
    select = 4'b1101;
    if (door == 1'h1) begin
        segments = 7'b1000011; end 
    else if (door == 1'h0) begin
        segments = 7'b0100011; end end

if (floorSel == 2'b10) begin
    select = 4'b1011; //active low logic
    if (door == 1'h1) begin
        segments = 7'b1000011; end 
    else if (door == 1'h0) begin
        segments = 7'b0100011; end end

if (floorSel == 2'b11) begin
    select = 4'b0111; //active low logic
    if (door == 1'h1) begin
        segments = 7'b1000011; end 
    else if (door == 1'h0) begin
        segments = 7'b0100011; end end
        
end
endmodule
