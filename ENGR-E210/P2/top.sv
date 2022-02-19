`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2021 03:42:45 PM
// Design Name: 
// Module Name: top
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


module top(
    input       	CLK100MHZ,
	input   [15:0]  sw,  //operands a,b,s
	input       	btnC, //
	output  [15:0]  LED //results c,v
);

	logic   [7:0] a;

	always @(posedge CLK100MHZ) begin
    	  if (btnC)
        	a <= sw[7:0];
	end

	alu alu0(
    	.a(a),
    	.b(sw[7:0]),
    	.s(sw[11:8]),
    	.r(LED[7:0]),
    	.c(LED[8]),
    	.v(LED[9])
    	);

	assign LED[15:12] = 5'b0;

endmodule
