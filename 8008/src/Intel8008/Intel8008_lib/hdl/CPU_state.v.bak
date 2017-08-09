//
// Verilog Module Intel8008_lib.CPU_state
//
// Created:
//          by - luoyin
//          at - 17:14:50 2017/08/ 5
//

`resetall
`timescale 1ns/10ps
`include "definition.v"

module CPU_state(IR, State, COND, READY, INT, State_next);
  input wire [7:0] IR;
  input wire [4:0] State;
  input wire COND, READY, INT;
  output reg [4:0] State_next;
  
  always @(State, IR, COND) begin
    case(State)
      `S_C1_T1: begin
        State_next=`S_C1_T2;
      end 
      `S_C1_T2: begin
        State_next=`S_C1_T3;
      end
      `S_C1_T3: begin
        casex(IR)
          // NOP/INr/DCr
          8'b00???00?: begin
            if(IR[5]+IR[4]+IR[3])
              // INr/DCr
              State_next=`S_C1_T4;      
            else
              // NOP
              State_next=`S_C1_T1;
          end
          // ROT
          8'b000??010: State_next=`S_C1_T4;
          // RFc/RTc
          8'b00???011: begin
            if(IR[5]^COND)
              State_next=`S_C1_T1;
            else
              State_next=`S_C1_T4;
          end
          // ALU op I
          8'b00???100: State_next=`S_C2_T1;
          // RST
          8'b00???101: State_next=`S_C1_T4;
          // LrI/LMI
          8'b00???110: State_next=`S_C2_T1;
          // RET
          8'b00???111: State_next=`S_C1_T4;
          // JUMP/CALL/INP/OUT
          8'b01??????: State_next=`S_C2_T1;
          // ALU
          8'b10??????: begin
            if(IR[2]&IR[1]&IR[0])
              // ALU op M
              State_next=`S_C2_T1;
            else
              // ALU op r
              State_next=`S_C1_T4;
          end
          // 
          8'b11??????: begin
            if(IR[5]&IR[4]&IR[3]&IR[2]&IR[1]&IR[0])
              // HLT
              State_next=`S_S;
            else if(IR[5]&IR[4]&IR[3])
              // LMr
              State_next=`S_C1_T4;
            else if(IR[2]&IR[1]&IR[0])
              // LrM
              State_next=`S_C2_T1;
            else
              // Lrr
              State_next=`S_C1_T4;
          end
          default: State_next=`S_C1_T1;
        endcase
      end
      `S_C1_T4: begin
        casex(IR)
          8'b11111???: State_next=`S_C2_T1;
          default: State_next=`S_C1_T5;
        endcase
      end
      `S_C1_T5: begin
      end
      `S_C2_T1: begin
        State_next=`S_C2_T2;
      end
      `S_C2_T2: begin
        State_next=`S_C2_T3;
      end
      `S_C2_T3: begin
        casex(IR)
          // ALU op I
          8'b00???100: State_next=`S_C2_T4;
          // 
          8'b00???110: begin
            if(IR[5]&IR[4]&IR[3])
              State_next=`S_C3_T1;
            else
              State_next=`S_C2_T4;
          end
          8'b01?????0: State_next=`S_C3_T1;
          8'b01?????1: begin
            if(IR[5]+IR[4]) begin
            end
            else
              State_next=`S_C2_T4;
          end
          8'b10???111: State_next=`S_C2_T4;
          8'b11??????: begin
            if(IR[2]&IR[1]&IR[0])
              State_next=`S_C2_T4;
            if(IR[5]&IR[4]&IR[3]) begin
            end
          end
          default: State_next=`S_C1_T1;
        endcase
      end
      `S_C2_T4: begin
        State_next=`S_C2_T5;
      end
      `S_C2_T5: begin
        
      end
      `S_C3_T1: begin
        State_next=`S_C3_T2;
      end
      `S_C3_T2: begin
        State_next=`S_C3_T3;
      end
      `S_C3_T3: begin
        casex(IR)
          8'b00111110: begin
          end
          8'b01???0?0: begin
            if(IR[5]^COND)
              ;
            else
              State_next=`S_C3_T4;
          end
          default: State_next=`S_C3_T4;
        endcase
      end
      `S_C3_T4: begin
        State_next=`S_C3_T5;
      end
      `S_C3_T5: begin
        State_next=`S_C1_T1;
      end
      `S_W: begin
        if(READY)
          State_next=(5'b11000&State)|3'b001;
          
        else
          State_next=`S_W;
      end
      `S_S: begin
        if(INT)
          State_next=`S_T1I;
        else
          State_next=State;
      end
      `S_T1I: begin
        State_next=`S_C1_T2;
      end
      default:;
    endcase
  end
  
  function func_int;
    input INT;
    begin
      if(INT)
        fuct_int=`S_T1I;
      else
        func_int=`S_C1_T1;
    end
  endfunction
  
  function func_wait;
    input READY, STATE0;
    begin
      if(READY)
        func_wait=STATE0;
      else
        func_wait=`S_W;
    end
  endfunction

endmodule
