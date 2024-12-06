
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/12 20:46:24
// Design Name: 
// Module Name: PIPE_END
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


module PIPE_END(
    input clk,
    input rst,
    input mode,
    input en,
    input [11:0] i1,
    input [11:0] i2,
    output [11:0] o1,
    output [11:0] o2
);
    reg [6:0] w_raddr;
    wire [11:0] BF_w;
    reg [6:0] begin_BF2, count_BF2;

    always @(posedge clk) begin
        if(!rst) begin
            begin_BF2 <= 0;
            count_BF2 <= 0;
            w_raddr <= (mode==0)?64:1;
        end
        else begin
            if(en==1) begin
                if(mode==0) begin
                    if(begin_BF2==(7*6+32+16+8+4+2)) begin
                        begin_BF2 <= begin_BF2;
                        if(w_raddr == 127) w_raddr <= 64;
                        else w_raddr <= w_raddr + 1;
                    end
                    else begin_BF2 <= begin_BF2 + 1;
                end
                else w_raddr <= w_raddr;
            end
        end
    end


    BROM BROM(clk, w_raddr,BF_w);

    BF BF(0,clk, rst, mode, en,BF_w, i1, i2, ntt_o1, ntt_o2);

    wire [11:0] ntt_o1, ntt_o2;
    reg [11:0] intt_i1, intt_i2;
    wire [11:0] intt_o1, intt_o2;
    always @(posedge clk) begin
        if(en==1) begin
            intt_i1 <= ntt_o1;
            intt_i2 <= ntt_o2;
        end
    end
    modmul modmul1(clk, en, 12'd3303, intt_i1, intt_o1);
    modmul modmul2(clk, en, 12'd3303, intt_i2, intt_o2);

    assign o1 = (mode==0)?ntt_o1:intt_o1;
    assign o2 = (mode==0)?ntt_o2:intt_o2;

endmodule




// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 2024/11/12 20:46:24
// // Design Name: 
// // Module Name: PIPE_END
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////


// module PIPE_END(
//     input clk,
//     input rst,
//     input mode,
//     input [11:0] i1,
//     input [11:0] i2,
//     output [11:0] o1,
//     output [11:0] o2
// );
//     reg [6:0] w_raddr;
//     wire [11:0] BF_w;
//     reg [6:0] begin_BF2, count_BF2;

//     always @(posedge clk or negedge rst) begin
//         if(!rst) begin
//             begin_BF2 <= 0;
//             count_BF2 <= 0;
//             w_raddr <= 64;
//         end
//         else begin
//             if(begin_BF2==(7*6+32+16+8+4+2)) begin
//                 begin_BF2 <= begin_BF2;
//                 if(w_raddr == 127) w_raddr <= 64;
//                 else w_raddr <= w_raddr + 1;
//             end
//             else begin_BF2 <= begin_BF2 + 1;
//         end
//     end


//     BROM BROM(clk, w_raddr,BF_w);

//     BF BF(clk, rst, mode, BF_w, i1, i2, o1, o2);

// endmodule
