//
// Verilog Module Intel8008_lib.CPU
//
// Created:
//          by - luoyin
//          at - 15:17:44 2017/08/ 5
//

`resetall
`timescale 1ns/10ps
`include "definition.v"

module CPU(D, CLK1, CLK2, nRST, READY, INT, SYNC, S);
  inout wire [7:0] D;
  input wire CLK1, CLK2, nRST, READY, INT;
  output reg SYNC;
  output reg [2:0] S;

  // State Machine
  reg [1:0] rCyc;       // Cycle
  reg [1:0] rCyc_next;
  reg [4:0] rState;
  reg [4:0] rState_next;
  reg [7:0] rIR;
  wire wCond;
  
  

endmodule
