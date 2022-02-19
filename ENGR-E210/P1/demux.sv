`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2021 02:50:03 PM
// Design Name: 
// Module Name: demux
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


module demux(
    input a, b, c,
	input e,
 	output d0, d1, d2, d3, d4, d5, d6, d7
    );
    
    wire wire0, wire1, wire2, wire3, wire4, wire5, wire6, wire7; // assign wires
    
    // submodules
  decoder dec(.a(a), .b(b), .c(c), .d0(wire0), .d1(wire1), .d2(wire2), .d3(wire3), .d4(wire4), .d5(wire5), .d6(wire6), .d7(wire7));
  assign d0 = wire0 & e;
  assign d1 = wire1 & e;
  assign d2 = wire2 & e;
  assign d3 = wire3 & e;
  assign d4 = wire4 & e;
  assign d5 = wire5 & e;
  assign d6 = wire6 & e;
  assign d7 = wire7 & e;
  
endmodule
