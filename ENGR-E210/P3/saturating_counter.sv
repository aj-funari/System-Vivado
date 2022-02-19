`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2021 12:40:35 PM
// Design Name: 
// Module Name: saturating_counter
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


module saturating_counter(
	input   clk,
	input   rst,
	input   enable,
	input   up_down,  //1 for up, 0 for down
	output logic [1:0] count
	);

//STATE NAMES 
enum { STATE_IDLE, STATE_ONE, STATE_TWO, STATE_THREE } state, nextState;

logic [1:0] nextCount;

//sequential block, uses Flip-Flops
always_ff @(posedge clk) begin
    if (rst) begin state <= STATE_IDLE; end
    else state <= nextState;
end

always_comb begin
    nextState = state; //default
    count = 2'b00;
    
    case(state)
        STATE_IDLE: begin count = 2'b00;
                    if (enable & up_down) //increase count/state 
                    nextState = STATE_ONE; 
                    else if (enable & ~up_down)
                    nextState = STATE_IDLE; 
                    else nextState = STATE_IDLE; end
        STATE_ONE: begin count = 2'b01;
                   if (enable & up_down) begin //increase count/state
                   nextState = STATE_TWO;
                   end else if (enable & ~up_down) begin //decrease count/state
                   nextState = STATE_IDLE; end 
                   else nextState = STATE_ONE; end
        STATE_TWO: begin count = 2'b10; 
                   if (enable & up_down) begin //increase count/state
                   nextState = STATE_THREE;
                   end else if (enable & ~up_down) begin //decrease count/state
                   nextState = STATE_ONE; end end
        STATE_THREE: begin count = 2'b11; 
                     if (enable & ~up_down) begin //decrease count/state
                     nextState = STATE_TWO; end
                     else if (enable & up_down)
                     nextState = STATE_THREE;
                     else nextState = STATE_THREE; end
    endcase end    
endmodule
