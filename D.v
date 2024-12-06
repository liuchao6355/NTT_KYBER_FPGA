`timescale 1ns / 1ps


module D#(
    parameter LEN=32
)(
    input clk,
    input en,
    // input rst,
    input [11:0] D_i,
    output [11:0] D_o
    );
    reg [11:0] D_store[0:LEN-1];
    integer i;
    always @(posedge clk) begin
        if(en==1) begin
            D_store[0] <= D_i;
            for (i = 0; i< LEN-1; i=i+1) begin
                D_store[i+1] <= D_store[i];
            end
        end
    end
    assign D_o = D_store[LEN-1];
endmodule
