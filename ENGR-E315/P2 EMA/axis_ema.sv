`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2020 05:46:53 AM
// Design Name: 
// Module Name: axis_ema
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


module axis_ema_sv(
    input           ACLK,
    input           ARESETN,

    input [31:0]    S_AXIS_TDATA,
    input [3:0]     S_AXIS_TKEEP,
    input           S_AXIS_TLAST,
    input           S_AXIS_TVALID,
    output          S_AXIS_TREADY,

    output [31:0]   M_AXIS_TDATA,
    output [3:0]    M_AXIS_TKEEP,
    output          M_AXIS_TLAST,
    output          M_AXIS_TVALID,
    input           M_AXIS_TREADY

    );

    //Update me!  By default this does nothing!   
//    assign M_AXIS_TDATA = ~S_AXIS_TDATA;
 
    enum {S0, S1} state, nextState;  // two states
    reg [31:0] nextVal;              // 32 bit array
    logic[31:0] previous_out;        // 32 bit array to store previous output
    logic[31:0] current_out;

    assign M_AXIS_TDATA = current_out;
    assign M_AXIS_TKEEP = S_AXIS_TKEEP;
    assign M_AXIS_TLAST = S_AXIS_TLAST;
    assign M_AXIS_TVALID = S_AXIS_TVALID; 
    assign S_AXIS_TREADY = M_AXIS_TREADY;   
    
    // use '<=' to assign in always__ff 
    always_ff @(posedge ACLK) begin
        if (~ARESETN) begin
            state <= S0;
            previous_out <= 'd1000; end
        else if (S_AXIS_TVALID && S_AXIS_TREADY) begin
            previous_out <= current_out; end 
    end
    
    // use '=' to assign in always_comb
    always_comb begin
        nextState = state;
        current_out = previous_out;
        
        case(state)
            S0: begin
                if (S_AXIS_TVALID && S_AXIS_TREADY)
                    current_out = (S_AXIS_TDATA >> 2) + (previous_out >> 2) + (previous_out >> 1); end
        endcase
    end
    
    endmodule