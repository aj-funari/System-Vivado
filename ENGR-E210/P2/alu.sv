`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2021 03:43:35 PM
// Design Name: 
// Module Name: alu
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


module alu(
   input        [7:0] a, //operand
   input        [7:0] b, //operand

   input        [3:0] s, //operation Select

   output logic [7:0] r, //the Result value
   output logic       c,  //for unsigned Carry
   output logic       v  //for signed oVerflow
   );
   
   always_comb
   begin
        c = 0;
        v = 0;
        case(s)
            4'b1110: r = a & b;
            4'b1101: r = a | b;
            4'b1100: r = ~a;
            4'b1011: r = a ^ b;
            4'b1010: begin
            {c,r} = a + b; 
            v = (~a[7] & ~b[7] & r[7]) | (a[7] & b[7] & ~r[7]);
                    end
            4'b1001: begin
            {c,r} = a + (~b + 1'b1); 
            v = (~a[7] & b[7] & r[7]) | (a[7] & ~b[7] & ~r[7]);
                    end
            4'b1000: r = a;
            4'b0111: r = (a==0);
        endcase
   end
endmodule
