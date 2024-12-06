`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/10 10:26:29
// Design Name: 
// Module Name: C2
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


module C2(
    input mode,
    input [11:0] i1,
    input [11:0] i2,
    output [11:0] o1,
    output [11:0] o2
    );

    assign o1 = (mode==0)?i1:i2;
    assign o2 = (mode==0)?i2:i1;
endmodule
