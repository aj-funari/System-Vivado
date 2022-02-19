`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2021 07:32:04 PM
// Design Name: 
// Module Name: ElevCtrl
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


module ElevCtrl(
    input        clk, //clock
    input        rst, //reset
    input [3:0]  floorBtn, //signal to send

    output logic [1:0] floorSel,
    output logic       door
);
//4-floor elevator
//7-segment drivers are active low logic (0 = "True"/"On", 1 = "False"/"Off")
//floor i (i= 1,2,3,4) -> match with LED's (GFEDCBA)

//STATE NAMES
enum { STATE1_OPEN, STATE1_CLOSE, STATE2_OPEN, STATE2_CLOSE, STATE3_OPEN,
       STATE3_CLOSE, STATE4_OPEN, STATE4_CLOSE } state, nextState;
logic [3:0] floorSave, nextFloorSave;

always_ff @(posedge clk) begin
    if (rst) begin
        state <= STATE1_OPEN; //magically teleport to floor 1 with door open
        floorSave <= 4'h0; end
    else begin
        state <= nextState;
        floorSave <= nextFloorSave; end
end

always_comb begin
    nextState = state;
    nextFloorSave = floorSave;
    floorSel = 2'b00;
    door = 1'h1;
    
    case(state)
        STATE1_CLOSE: begin floorSel = 2'b00; door = 1'h0; //floor 1 & door close
                      if (floorSave == 4'b0001) begin
                      nextState = STATE1_OPEN; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0010) begin
                      nextState = STATE2_CLOSE;
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0100) begin
                      nextState = STATE2_CLOSE;
                      nextFloorSave = floorSave; end 
                      else if (floorSave == 4'b1000) begin
                      nextState = STATE2_CLOSE;
                      nextFloorSave = floorSave; end end
                      
        STATE2_CLOSE: begin floorSel = 2'b01; door = 1'h0; //floor 2 & door close
                      if (floorSave == 4'b0001) begin
                      nextState = STATE1_CLOSE; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0010) begin
                      nextState = STATE2_OPEN; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0100) begin
                      nextState = STATE3_CLOSE;
                      nextFloorSave = floorSave; end 
                      else if (floorSave == 4'b1000) begin
                      nextState = STATE3_CLOSE; 
                      nextFloorSave = floorSave; end end
                      
        STATE3_CLOSE: begin floorSel = 2'b10; door = 1'h0; //floor 3 & door close
                      if (floorSave == 4'b0001) begin
                      nextState = STATE2_CLOSE; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0010) begin
                      nextState = STATE2_CLOSE; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0100) begin
                      nextState = STATE3_OPEN;
                      nextFloorSave = floorSave; end 
                      else if (floorSave == 4'b1000) begin
                      nextState = STATE4_CLOSE; 
                      nextFloorSave = floorSave; end end
                      
        STATE4_CLOSE: begin floorSel = 2'b11; door = 1'h0; //floor 4 & door close
                      if (floorSave == 4'b0001) begin
                      nextState = STATE3_CLOSE; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0010) begin
                      nextState = STATE3_CLOSE; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0100) begin
                      nextState = STATE3_CLOSE;
                      nextFloorSave = floorSave; end 
                      else if (floorSave == 4'b1000) begin
                      nextState = STATE4_OPEN; 
                      nextFloorSave = floorSave; end end
                      
        STATE1_OPEN:  begin floorSel = 2'b00; door = 1'h1; //floor 1 & door open
                      if (floorSave == 4'b0001) begin
                      nextState = STATE1_OPEN;
                      nextFloorSave = 0; end
                      else if (floorSave == 4'b0010) begin
                      nextState = STATE1_CLOSE; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0100) begin
                      nextState = STATE1_CLOSE; 
                      nextFloorSave = floorSave; end 
                      else if (floorSave == 4'b1000) begin
                      nextState = STATE1_CLOSE; 
                      nextFloorSave = floorSave; end
                       
                      else begin
                      door = 1'h1; nextState = STATE1_OPEN;
                      nextFloorSave = 0;
                      if (floorBtn == 4'b0010) begin
                      nextState = STATE1_CLOSE; 
                      nextFloorSave = floorBtn; end
                      else if (floorBtn == 4'b0100) begin
                      nextState = STATE1_CLOSE; 
                      nextFloorSave = floorBtn; end
                      else if (floorBtn == 4'b1000) begin
                      nextState = STATE1_CLOSE;
                      nextFloorSave = floorBtn; end end end 
                      
        STATE2_OPEN:  begin floorSel = 2'b01; door = 1'h1; //floor 2 & door open
                      if (floorSave == 4'b0001) begin
                      nextState = STATE2_CLOSE; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0010) begin
                      nextState = STATE2_OPEN; 
                      nextFloorSave = 0; end
                      else if (floorSave == 4'b0100) begin
                      nextState = STATE2_CLOSE; 
                      nextFloorSave = floorSave; end 
                      else if (floorSave == 4'b1000) begin
                      nextState = STATE2_CLOSE; 
                      nextFloorSave = floorSave; end
                      
                      else begin
                      door = 1'h1; nextState = STATE2_OPEN;
                      nextFloorSave = 0;
                      if (floorBtn == 4'b0001) begin
                      nextState = STATE2_CLOSE;
                      nextFloorSave = floorBtn; end
                      else if (floorBtn == 4'b0100) begin
                      nextState = STATE2_CLOSE;
                      nextFloorSave = floorBtn; end
                      else if (floorBtn == 4'b1000) begin
                      nextState = STATE2_CLOSE;
                      nextFloorSave = floorBtn; end end end

        STATE3_OPEN:  begin floorSel = 2'b10; door = 1'h1; //floor 3 & door open
                      if (floorSave == 4'b0001) begin
                      nextState = STATE3_CLOSE; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0010) begin
                      nextState = STATE3_CLOSE; 
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0100) begin
                      nextState = STATE3_OPEN;
                      nextFloorSave = 0; end 
                      else if (floorSave == 4'b1000) begin
                      nextState = STATE3_CLOSE; 
                      nextFloorSave = floorSave; end
                      
                      else begin
                      door = 1'h1; nextState = STATE3_OPEN;
                      nextFloorSave = 0;
                      if (floorBtn == 4'b0001) begin
                      nextState = STATE3_CLOSE;
                      nextFloorSave = floorBtn; end
                      else if (floorBtn == 4'b0010) begin
                      nextState = STATE3_CLOSE;
                      nextFloorSave = floorBtn; end
                      else if (floorBtn == 4'b1000) begin
                      nextState = STATE3_CLOSE;
                      nextFloorSave = floorBtn; end end end
                      
        STATE4_OPEN:  begin floorSel = 2'b11; door = 1'h1; //floor 4 & door open
                      if (floorSave == 4'b0001) begin
                      nextState = STATE4_CLOSE;
                      nextFloorSave = floorSave; end
                      else if (floorSave == 4'b0010) begin
                      nextState = STATE4_CLOSE; end
                      else if (floorSave == 4'b0100) begin
                      nextState = STATE4_CLOSE; end 
                      else if (floorSave == 4'b1000) begin
                      nextState = STATE4_OPEN; 
                      nextFloorSave = 0; end
                      
                      else begin
                      door = 1'h1; nextState = STATE4_OPEN;
                      nextFloorSave = 0;
                      if (floorBtn == 4'b0001) begin
                      nextState = STATE4_CLOSE;
                      nextFloorSave = floorBtn; end
                      else if (floorBtn == 4'b0010) begin
                      nextState = STATE4_CLOSE;
                      nextFloorSave = floorBtn; end
                      else if (floorBtn == 4'b0100) begin
                      nextState = STATE4_CLOSE;
                      nextFloorSave = floorBtn; end end end 
    endcase
end
endmodule