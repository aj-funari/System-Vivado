`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2021 03:44:38 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb;
    logic [7:0] a, b;     //inputs
    logic [3:0] s;        //select
    logic [7:0] r;        //result
    logic c, v;           //carry, overflow
    
    alu alu0 (
        .a(a),
        .b(b),
        .s(s),
        .r(r),
        .c(c),
        .v(v)
    );
    
    task alu_test;
        input [7:0] aT, bT;
        input [3:0] sT;
        input [7:0] rT;
        input cT, vT;
        
        #100
        a = aT; b = bT; s = sT;
        #100
        assert( ( r == rT ) && ( c == cT ) && ( v == vT ) )
            else $fatal(1, "alu0(%b,%b,%b) failed!", a, b, s);
    endtask
    
    initial
    begin
        $monitor("a:%b, b:%b, s:%b, r:%b, c:%b, v:%b", a,b,s,r,c,v);
        alu_test(8'b00000001,8'b00000001,4'b1110,8'b00000001,0,0); //and
        alu_test(8'b00000001,8'b00000001,4'b1101,8'b00000001,0,0); //or
        alu_test(8'b00000001,8'b00000000,4'b1100,8'b11111110,0,0); //not
        alu_test(8'b00000001,8'b00000001,4'b1011,8'b00000000,0,0); //xor
        alu_test(8'b00000001,8'b00000000,4'b1000,8'b00000001,0,0); //transfer
        alu_test(8'b00000000,8'b00000000,4'b0111,8'b00000001,0,0); //test
        alu_test(255,0,'b0111,0,0,0);
        
        alu_test(200,100,4'b1010,8'b00101100,1,0); //add
        alu_test(8'b00000001,8'b00000001,4'b1001,8'b00000000,0,0); //sub
        
        $display("@@@Passed");
        $finish;
    end      
endmodule
