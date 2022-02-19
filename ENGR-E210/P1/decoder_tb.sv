`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/29/2021 03:05:27 PM
// Design Name: 
// Module Name: decoder_tb
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


module decoder_tb;
    logic a, b, c;
    logic d0,d1,d2,d3,d4,d5,d6,d7;

    decoder dec0 (
        .a(a),
        .b(b),
        .c(c),
        .d0(d0), 
        .d1(d1), 
        .d2(d2),
        .d3(d3),
        .d4(d4),
        .d5(d5),
        .d6(d6),
        .d7(d7)
    );


    task decoder_test;
    	  input aT, bT, cT;
    	  input d0T, d1T, d2T, d3T, d4T;
    	  input d5T, d6T, d7T;

    	  #5
    	  a = aT; b=bT; c=cT;
    	  #5
    	  assert( ( d0 == d0T ) && ( d1 == d1T )  &&
            	( d2 == d2T ) && ( d3 == d3T )  &&
            	( d4 == d4T ) && ( d5 == d5T )  &&
            	( d6 == d6T ) && ( d7 == d7T ) )
        	else $fatal(1,"dec0(%b,%b,%b) failed!", a, b, c);
    endtask

    initial
    begin
        a = 0; b = 0; c = 0;
        #10

        $monitor("%h%h%h%h%h%h%h%h",
                    d0,d1,d2,d3,d4,d5,d6,d7); 
    	   
        decoder_test(0,0,0, 1,0,0,0,0,0,0,0);
        decoder_test(0,0,1, 0,1,0,0,0,0,0,0);
        decoder_test(0,1,0, 0,0,1,0,0,0,0,0);
        decoder_test(0,1,1, 0,0,0,1,0,0,0,0);
        decoder_test(1,0,0, 0,0,0,0,1,0,0,0);
        decoder_test(1,0,1, 0,0,0,0,0,1,0,0);
        decoder_test(1,1,0, 0,0,0,0,0,0,1,0);
        decoder_test(1,1,1, 0,0,0,0,0,0,0,1);
        $display("@@@Passed");
        $finish;
    end
endmodule
