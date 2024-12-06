module modmul(
    input clk,
    input en,
    input [11:0] a,
    input [11:0] b,
    output [11:0] c
);
    wire [11:0] q;

    wire [23:0] w_tmp;
    reg [23:0] r_tmp;

    always @(posedge clk) begin
        if(en==1) r_tmp <= w_tmp; 
    end

    mul mul(clk, a, b, w_tmp);
    reduc reduc(clk,en, r_tmp, c, q);

endmodule

//无en
module modmul2(
    input clk,
    // input en,
    input [11:0] a,
    input [11:0] b,
    output [11:0] c
);
    wire [11:0] q;

    wire [23:0] w_tmp;
    reg [23:0] r_tmp;

    always @(posedge clk) begin
        // if(en==1) r_tmp <= w_tmp; 
        r_tmp <= w_tmp; 
    end

    mul mul(clk, a, b, w_tmp);
    reduc2 reduc(clk, r_tmp, c, q);

endmodule



// module modmul_top(input         clk,
//               input  [11:0] A,B,
//               output [11:0] R
//               );
//               reg [11:0] Ai,Bi;
//               always @(posedge clk) begin
//                 Ai <= A+23;
//                 Bi <= B+43;
//               end

//               modmul modmul(clk,Ai,Bi,R);
// endmodule

// module modmul(input         clk,
//               input  [11:0] A,B,
//               output [11:0] R);

// wire [23:0] P;
// reg  [23:0] P_R;

// intmul im0(A,B,P);

// always @(posedge clk) begin
//     // if(rst) begin
//     //     P_R <= 0;
//     // end
//     // else begin
//         P_R <= P;
//     // end
// end

// // ---------------------------------------

// modred mr0(P_R,R);

// endmodule




// module intmul(input [11:0] A,B,
//               output[23:0] P);

// (* use_dsp = "no" *) reg [23:0] P_DSP;

// always @* P_DSP = A*B;

// assign P = P_DSP;

// endmodule

// module modred(input      [23:0] C,
//               output reg [11:0] R);

//     // First Stage
//     wire [14:0] C0;
//     wire [14:0] S0;

//     dt0 level4_00 (
//     {C[0],!C[12],!C[14],!C[17],!C[18],!C[19],!C[20]},
//     {C[1],!C[13],!C[15],!C[17],!C[18],!C[20],!C[21],1'b1},
//     {C[2],!C[14],!C[16],!C[17],!C[18],!C[19],!C[21],!C[22]},
//     {C[3],!C[15],!C[18],!C[19],!C[20],!C[22],!C[23]},
//     {C[4],!C[16],!C[19],!C[20],!C[21],!C[23],1'b1},
//     {C[5],!C[17],!C[20],!C[21],!C[22]},
//     {C[6],!C[18],!C[21],!C[22],!C[23],1'b1},
//     {C[7],!C[19],!C[22],!C[23]},
//     {C[8], C[12],C[17],C[19],C[21],!C[14],!C[18],!C[21],!C[23]},
//     {C[9], C[12],C[13],C[15],C[19],C[18]},
//     {C[10],C[13],C[17],C[19],!C[18],!C[16],!C[15],1'b1},
//     {C[11],1'b1},
//     1'b1,
//     1'b1,
//     C0,S0
//     );

//     // Final Stage
//     wire [14:0] R0,R1,R2,R3,R4,R5;

//     dt1 level5_00(
//     {C0[0] ,S0[0] ,1'b1},
//     {C0[1] ,S0[1] ,1'b1},
//     {C0[2] ,S0[2] ,1'b1},
//     {C0[3] ,S0[3] ,1'b1},
//     {C0[4] ,S0[4] ,1'b1},
//     {C0[5] ,S0[5] ,1'b1},
//     {C0[6] ,S0[6] ,1'b1},
//     {C0[7] ,S0[7] ,1'b1},
//     {C0[8] ,S0[8] },
//     {C0[9] ,S0[9] ,1'b1},
//     {C0[10],S0[10]},
//     {C0[11],S0[11]},
//     {C0[12],S0[12],1'b1},
//     {C0[13],S0[13],1'b1},
//     {C0[14],S0[14],1'b1},
//     R0,R1);

//     dt2 level5_01(
//     {C0[0] ,S0[0] },
//     {C0[1] ,S0[1] ,1'b1},
//     {C0[2] ,S0[2] ,1'b1},
//     {C0[3] ,S0[3] ,1'b1},
//     {C0[4] ,S0[4] ,1'b1},
//     {C0[5] ,S0[5] ,1'b1},
//     {C0[6] ,S0[6] ,1'b1},
//     {C0[7] ,S0[7] ,1'b1},
//     {C0[8] ,S0[8] ,1'b1},
//     {C0[9] ,S0[9] },
//     {C0[10],S0[10],1'b1},
//     {C0[11],S0[11]},
//     {C0[12],S0[12]},
//     {C0[13],S0[13],1'b1},
//     {C0[14],S0[14],1'b1},
//     R2,R3);

//     dt3 level5_02(
//     {C0[0] ,S0[0] ,1'b1},
//     {C0[1] ,S0[1] },
//     {C0[2] ,S0[2] },
//     {C0[3] ,S0[3] },
//     {C0[4] ,S0[4] },
//     {C0[5] ,S0[5] },
//     {C0[6] ,S0[6] },
//     {C0[7] ,S0[7] },
//     {C0[8] ,S0[8] ,1'b1},
//     {C0[9] ,S0[9] },
//     {C0[10],S0[10],1'b1},
//     {C0[11],S0[11],1'b1},
//     {C0[12],S0[12]},
//     {C0[13],S0[13]},
//     {C0[14],S0[14]},
//     R4,R5);

//     wire [14:0] Rmp0;
//     wire [14:0] Rm1q,Rm2q,Rp1q;

//     assign Rmp0 = C0+S0;

//     assign Rm1q = R0+R1;
//     assign Rm2q = R2+R3;
//     assign Rp1q = R4+R5;

//     always @(*) begin
//         if(Rm2q[14] == 0)
//             R = Rm2q[11:0];
//         else if(Rm1q[14] == 0)
//             R = Rm1q[11:0];
//         else if(Rmp0[14] == 0)
//             R = Rmp0[11:0];
//         else
//             R = Rp1q[11:0];
//     end

// endmodule


// /*
// The designers:

// Ahmet Can Mert <ahmetcanmert@sabanciuniv.edu>
// Ferhat Yaman <ferhatyaman@sabanciuniv.edu>

// To the extent possible under law, the implementer has waived all copyright
// and related or neighboring rights to the source code in this file.
// http://creativecommons.org/publicdomain/zero/1.0/
// */

// module dt0(
//     input [7-1:0] t0_0,
//     input [8-1:0] t0_1,
//     input [8-1:0] t0_2,
//     input [7-1:0] t0_3,
//     input [7-1:0] t0_4,
//     input [5-1:0] t0_5,
//     input [6-1:0] t0_6,
//     input [4-1:0] t0_7,
//     input [9-1:0] t0_8,
//     input [6-1:0] t0_9,
//     input [8-1:0] t0_10,
//     input [2-1:0] t0_11,
//     input [1-1:0] t0_13,
//     input [1-1:0] t0_14,
//     output [15-1:0] s,
//     output [15-1:0] c);

// // ------------------------------- Connections

//     // --------------------- Level 1

//     wire [6-1:0] t1_0;
//     wire [6-1:0] t1_1;
//     wire [6-1:0] t1_2;
//     wire [6-1:0] t1_3;
//     wire [6-1:0] t1_4;
//     wire [6-1:0] t1_5;
//     wire [6-1:0] t1_6;
//     wire [5-1:0] t1_7;
//     wire [6-1:0] t1_8;
//     wire [6-1:0] t1_9;
//     wire [6-1:0] t1_10;
//     wire [4-1:0] t1_11;
//     wire [1-1:0] t1_13;
//     wire [1-1:0] t1_14;

//     // --------------------- Level 2

//     wire [4-1:0] t2_0;
//     wire [4-1:0] t2_1;
//     wire [4-1:0] t2_2;
//     wire [4-1:0] t2_3;
//     wire [4-1:0] t2_4;
//     wire [4-1:0] t2_5;
//     wire [4-1:0] t2_6;
//     wire [4-1:0] t2_7;
//     wire [4-1:0] t2_8;
//     wire [4-1:0] t2_9;
//     wire [4-1:0] t2_10;
//     wire [4-1:0] t2_11;
//     wire [1-1:0] t2_12;
//     wire [1-1:0] t2_13;
//     wire [1-1:0] t2_14;

//     // --------------------- Level 3

//     wire [3-1:0] t3_0;
//     wire [3-1:0] t3_1;
//     wire [3-1:0] t3_2;
//     wire [3-1:0] t3_3;
//     wire [3-1:0] t3_4;
//     wire [3-1:0] t3_5;
//     wire [3-1:0] t3_6;
//     wire [3-1:0] t3_7;
//     wire [3-1:0] t3_8;
//     wire [3-1:0] t3_9;
//     wire [3-1:0] t3_10;
//     wire [3-1:0] t3_11;
//     wire [2-1:0] t3_12;
//     wire [1-1:0] t3_13;
//     wire [1-1:0] t3_14;

//     // --------------------- Level 4

//     wire [2-1:0] t4_0;
//     wire [2-1:0] t4_1;
//     wire [2-1:0] t4_2;
//     wire [2-1:0] t4_3;
//     wire [2-1:0] t4_4;
//     wire [2-1:0] t4_5;
//     wire [2-1:0] t4_6;
//     wire [2-1:0] t4_7;
//     wire [2-1:0] t4_8;
//     wire [2-1:0] t4_9;
//     wire [2-1:0] t4_10;
//     wire [2-1:0] t4_11;
//     wire [2-1:0] t4_12;
//     wire [2-1:0] t4_13;
//     wire [1-1:0] t4_14;

// // ------------------------------- Operations

//     // --------------------- Level 1

//     HA u000(t0_0[0],t0_0[1],t1_1[0],t1_0[0]);
//     assign t1_0[1] = t0_0[2];
//     assign t1_0[2] = t0_0[3];
//     assign t1_0[3] = t0_0[4];
//     assign t1_0[4] = t0_0[5];
//     assign t1_0[5] = t0_0[6];
//     FA u010(t0_1[0],t0_1[1],t0_1[2],t1_2[0],t1_1[1]);
//     HA u011(t0_1[3],t0_1[4],t1_2[1],t1_1[2]);
//     assign t1_1[3] = t0_1[5];
//     assign t1_1[4] = t0_1[6];
//     assign t1_1[5] = t0_1[7];
//     FA u020(t0_2[0],t0_2[1],t0_2[2],t1_3[0],t1_2[2]);
//     FA u021(t0_2[3],t0_2[4],t0_2[5],t1_3[1],t1_2[3]);
//     assign t1_2[4] = t0_2[6];
//     assign t1_2[5] = t0_2[7];
//     FA u030(t0_3[0],t0_3[1],t0_3[2],t1_4[0],t1_3[2]);
//     HA u031(t0_3[3],t0_3[4],t1_4[1],t1_3[3]);
//     assign t1_3[4] = t0_3[5];
//     assign t1_3[5] = t0_3[6];
//     FA u040(t0_4[0],t0_4[1],t0_4[2],t1_5[0],t1_4[2]);
//     HA u041(t0_4[3],t0_4[4],t1_5[1],t1_4[3]);
//     assign t1_4[4] = t0_4[5];
//     assign t1_4[5] = t0_4[6];
//     HA u050(t0_5[0],t0_5[1],t1_6[0],t1_5[2]);
//     assign t1_5[3] = t0_5[2];
//     assign t1_5[4] = t0_5[3];
//     assign t1_5[5] = t0_5[4];
//     HA u060(t0_6[0],t0_6[1],t1_7[0],t1_6[1]);
//     assign t1_6[2] = t0_6[2];
//     assign t1_6[3] = t0_6[3];
//     assign t1_6[4] = t0_6[4];
//     assign t1_6[5] = t0_6[5];
//     assign t1_7[1] = t0_7[0];
//     assign t1_7[2] = t0_7[1];
//     assign t1_7[3] = t0_7[2];
//     assign t1_7[4] = t0_7[3];
//     FA u080(t0_8[0],t0_8[1],t0_8[2],t1_9[0],t1_8[0]);
//     HA u081(t0_8[3],t0_8[4],t1_9[1],t1_8[1]);
//     assign t1_8[2] = t0_8[5];
//     assign t1_8[3] = t0_8[6];
//     assign t1_8[4] = t0_8[7];
//     assign t1_8[5] = t0_8[8];
//     FA u090(t0_9[0],t0_9[1],t0_9[2],t1_10[0],t1_9[2]);
//     assign t1_9[3] = t0_9[3];
//     assign t1_9[4] = t0_9[4];
//     assign t1_9[5] = t0_9[5];
//     FA u0100(t0_10[0],t0_10[1],t0_10[2],t1_11[0],t1_10[1]);
//     HA u0101(t0_10[3],t0_10[4],t1_11[1],t1_10[2]);
//     assign t1_10[3] = t0_10[5];
//     assign t1_10[4] = t0_10[6];
//     assign t1_10[5] = t0_10[7];
//     assign t1_11[2] = t0_11[0];
//     assign t1_11[3] = t0_11[1];
//     assign t1_13[0] = t0_13[0];
//     assign t1_14[0] = t0_14[0];

//     // --------------------- Level 2

//     FA u100(t1_0[0],t1_0[1],t1_0[2],t2_1[0],t2_0[0]);
//     assign t2_0[1] = t1_0[3];
//     assign t2_0[2] = t1_0[4];
//     assign t2_0[3] = t1_0[5];
//     FA u110(t1_1[0],t1_1[1],t1_1[2],t2_2[0],t2_1[1]);
//     HA u111(t1_1[3],t1_1[4],t2_2[1],t2_1[2]);
//     assign t2_1[3] = t1_1[5];
//     FA u120(t1_2[0],t1_2[1],t1_2[2],t2_3[0],t2_2[2]);
//     FA u121(t1_2[3],t1_2[4],t1_2[5],t2_3[1],t2_2[3]);
//     FA u130(t1_3[0],t1_3[1],t1_3[2],t2_4[0],t2_3[2]);
//     FA u131(t1_3[3],t1_3[4],t1_3[5],t2_4[1],t2_3[3]);
//     FA u140(t1_4[0],t1_4[1],t1_4[2],t2_5[0],t2_4[2]);
//     FA u141(t1_4[3],t1_4[4],t1_4[5],t2_5[1],t2_4[3]);
//     FA u150(t1_5[0],t1_5[1],t1_5[2],t2_6[0],t2_5[2]);
//     FA u151(t1_5[3],t1_5[4],t1_5[5],t2_6[1],t2_5[3]);
//     FA u160(t1_6[0],t1_6[1],t1_6[2],t2_7[0],t2_6[2]);
//     FA u161(t1_6[3],t1_6[4],t1_6[5],t2_7[1],t2_6[3]);
//     FA u170(t1_7[0],t1_7[1],t1_7[2],t2_8[0],t2_7[2]);
//     HA u171(t1_7[3],t1_7[4],t2_8[1],t2_7[3]);
//     FA u180(t1_8[0],t1_8[1],t1_8[2],t2_9[0],t2_8[2]);
//     FA u181(t1_8[3],t1_8[4],t1_8[5],t2_9[1],t2_8[3]);
//     FA u190(t1_9[0],t1_9[1],t1_9[2],t2_10[0],t2_9[2]);
//     FA u191(t1_9[3],t1_9[4],t1_9[5],t2_10[1],t2_9[3]);
//     FA u1100(t1_10[0],t1_10[1],t1_10[2],t2_11[0],t2_10[2]);
//     FA u1101(t1_10[3],t1_10[4],t1_10[5],t2_11[1],t2_10[3]);
//     FA u1110(t1_11[0],t1_11[1],t1_11[2],t2_12[0],t2_11[2]);
//     assign t2_11[3] = t1_11[3];
//     assign t2_13[0] = t1_13[0];
//     assign t2_14[0] = t1_14[0];

//     // --------------------- Level 3

//     HA u200(t2_0[0],t2_0[1],t3_1[0],t3_0[0]);
//     assign t3_0[1] = t2_0[2];
//     assign t3_0[2] = t2_0[3];
//     FA u210(t2_1[0],t2_1[1],t2_1[2],t3_2[0],t3_1[1]);
//     assign t3_1[2] = t2_1[3];
//     FA u220(t2_2[0],t2_2[1],t2_2[2],t3_3[0],t3_2[1]);
//     assign t3_2[2] = t2_2[3];
//     FA u230(t2_3[0],t2_3[1],t2_3[2],t3_4[0],t3_3[1]);
//     assign t3_3[2] = t2_3[3];
//     FA u240(t2_4[0],t2_4[1],t2_4[2],t3_5[0],t3_4[1]);
//     assign t3_4[2] = t2_4[3];
//     FA u250(t2_5[0],t2_5[1],t2_5[2],t3_6[0],t3_5[1]);
//     assign t3_5[2] = t2_5[3];
//     FA u260(t2_6[0],t2_6[1],t2_6[2],t3_7[0],t3_6[1]);
//     assign t3_6[2] = t2_6[3];
//     FA u270(t2_7[0],t2_7[1],t2_7[2],t3_8[0],t3_7[1]);
//     assign t3_7[2] = t2_7[3];
//     FA u280(t2_8[0],t2_8[1],t2_8[2],t3_9[0],t3_8[1]);
//     assign t3_8[2] = t2_8[3];
//     FA u290(t2_9[0],t2_9[1],t2_9[2],t3_10[0],t3_9[1]);
//     assign t3_9[2] = t2_9[3];
//     FA u2100(t2_10[0],t2_10[1],t2_10[2],t3_11[0],t3_10[1]);
//     assign t3_10[2] = t2_10[3];
//     FA u2110(t2_11[0],t2_11[1],t2_11[2],t3_12[0],t3_11[1]);
//     assign t3_11[2] = t2_11[3];
//     assign t3_12[1] = t2_12[0];
//     assign t3_13[0] = t2_13[0];
//     assign t3_14[0] = t2_14[0];

//     // --------------------- Level 4

//     HA u300(t3_0[0],t3_0[1],t4_1[0],t4_0[0]);
//     assign t4_0[1] = t3_0[2];
//     FA u310(t3_1[0],t3_1[1],t3_1[2],t4_2[0],t4_1[1]);
//     FA u320(t3_2[0],t3_2[1],t3_2[2],t4_3[0],t4_2[1]);
//     FA u330(t3_3[0],t3_3[1],t3_3[2],t4_4[0],t4_3[1]);
//     FA u340(t3_4[0],t3_4[1],t3_4[2],t4_5[0],t4_4[1]);
//     FA u350(t3_5[0],t3_5[1],t3_5[2],t4_6[0],t4_5[1]);
//     FA u360(t3_6[0],t3_6[1],t3_6[2],t4_7[0],t4_6[1]);
//     FA u370(t3_7[0],t3_7[1],t3_7[2],t4_8[0],t4_7[1]);
//     FA u380(t3_8[0],t3_8[1],t3_8[2],t4_9[0],t4_8[1]);
//     FA u390(t3_9[0],t3_9[1],t3_9[2],t4_10[0],t4_9[1]);
//     FA u3100(t3_10[0],t3_10[1],t3_10[2],t4_11[0],t4_10[1]);
//     FA u3110(t3_11[0],t3_11[1],t3_11[2],t4_12[0],t4_11[1]);
//     HA u3120(t3_12[0],t3_12[1],t4_13[0],t4_12[1]);
//     assign t4_13[1] = t3_13[0];
//     assign t4_14[0] = t3_14[0];

//     // --------------------- Rewire

//     assign c[0] = t4_0[0];
//     assign c[1] = t4_1[0];
//     assign c[2] = t4_2[0];
//     assign c[3] = t4_3[0];
//     assign c[4] = t4_4[0];
//     assign c[5] = t4_5[0];
//     assign c[6] = t4_6[0];
//     assign c[7] = t4_7[0];
//     assign c[8] = t4_8[0];
//     assign c[9] = t4_9[0];
//     assign c[10] = t4_10[0];
//     assign c[11] = t4_11[0];
//     assign c[12] = t4_12[0];
//     assign c[13] = t4_13[0];
//     assign c[14] = t4_14[0];
//     assign s[0] = t4_0[1];
//     assign s[1] = t4_1[1];
//     assign s[2] = t4_2[1];
//     assign s[3] = t4_3[1];
//     assign s[4] = t4_4[1];
//     assign s[5] = t4_5[1];
//     assign s[6] = t4_6[1];
//     assign s[7] = t4_7[1];
//     assign s[8] = t4_8[1];
//     assign s[9] = t4_9[1];
//     assign s[10] = t4_10[1];
//     assign s[11] = t4_11[1];
//     assign s[12] = t4_12[1];
//     assign s[13] = t4_13[1];
//     assign s[14] = 1'b0;

// endmodule


// /*
// The designers:

// Ahmet Can Mert <ahmetcanmert@sabanciuniv.edu>
// Ferhat Yaman <ferhatyaman@sabanciuniv.edu>

// To the extent possible under law, the implementer has waived all copyright
// and related or neighboring rights to the source code in this file.
// http://creativecommons.org/publicdomain/zero/1.0/
// */

// module dt1(
//     input [3-1:0] t0_0,
//     input [3-1:0] t0_1,
//     input [3-1:0] t0_2,
//     input [3-1:0] t0_3,
//     input [3-1:0] t0_4,
//     input [3-1:0] t0_5,
//     input [3-1:0] t0_6,
//     input [3-1:0] t0_7,
//     input [2-1:0] t0_8,
//     input [3-1:0] t0_9,
//     input [2-1:0] t0_10,
//     input [2-1:0] t0_11,
//     input [3-1:0] t0_12,
//     input [3-1:0] t0_13,
//     input [3-1:0] t0_14,
//     output [15-1:0] s,
//     output [15-1:0] c);

// // ------------------------------- Connections

//     // --------------------- Level 1

//     wire [2-1:0] t1_0;
//     wire [2-1:0] t1_1;
//     wire [2-1:0] t1_2;
//     wire [2-1:0] t1_3;
//     wire [2-1:0] t1_4;
//     wire [2-1:0] t1_5;
//     wire [2-1:0] t1_6;
//     wire [2-1:0] t1_7;
//     wire [2-1:0] t1_8;
//     wire [2-1:0] t1_9;
//     wire [2-1:0] t1_10;
//     wire [2-1:0] t1_11;
//     wire [2-1:0] t1_12;
//     wire [2-1:0] t1_13;
//     wire [2-1:0] t1_14;

// // ------------------------------- Operations

//     // --------------------- Level 1

//     HA u000(t0_0[0],t0_0[1],t1_1[0],t1_0[0]);
//     assign t1_0[1] = t0_0[2];
//     FA u010(t0_1[0],t0_1[1],t0_1[2],t1_2[0],t1_1[1]);
//     FA u020(t0_2[0],t0_2[1],t0_2[2],t1_3[0],t1_2[1]);
//     FA u030(t0_3[0],t0_3[1],t0_3[2],t1_4[0],t1_3[1]);
//     FA u040(t0_4[0],t0_4[1],t0_4[2],t1_5[0],t1_4[1]);
//     FA u050(t0_5[0],t0_5[1],t0_5[2],t1_6[0],t1_5[1]);
//     FA u060(t0_6[0],t0_6[1],t0_6[2],t1_7[0],t1_6[1]);
//     FA u070(t0_7[0],t0_7[1],t0_7[2],t1_8[0],t1_7[1]);
//     HA u080(t0_8[0],t0_8[1],t1_9[0],t1_8[1]);
//     FA u090(t0_9[0],t0_9[1],t0_9[2],t1_10[0],t1_9[1]);
//     HA u0100(t0_10[0],t0_10[1],t1_11[0],t1_10[1]);
//     HA u0110(t0_11[0],t0_11[1],t1_12[0],t1_11[1]);
//     FA u0120(t0_12[0],t0_12[1],t0_12[2],t1_13[0],t1_12[1]);
//     FA u0130(t0_13[0],t0_13[1],t0_13[2],t1_14[0],t1_13[1]);
//     FA u0140(t0_14[0],t0_14[1],t0_14[2],dummy_var_0,t1_14[1]);

//     // --------------------- Rewire

//     assign c[0] = t1_0[0];
//     assign c[1] = t1_1[0];
//     assign c[2] = t1_2[0];
//     assign c[3] = t1_3[0];
//     assign c[4] = t1_4[0];
//     assign c[5] = t1_5[0];
//     assign c[6] = t1_6[0];
//     assign c[7] = t1_7[0];
//     assign c[8] = t1_8[0];
//     assign c[9] = t1_9[0];
//     assign c[10] = t1_10[0];
//     assign c[11] = t1_11[0];
//     assign c[12] = t1_12[0];
//     assign c[13] = t1_13[0];
//     assign c[14] = t1_14[0];
//     assign s[0] = t1_0[1];
//     assign s[1] = t1_1[1];
//     assign s[2] = t1_2[1];
//     assign s[3] = t1_3[1];
//     assign s[4] = t1_4[1];
//     assign s[5] = t1_5[1];
//     assign s[6] = t1_6[1];
//     assign s[7] = t1_7[1];
//     assign s[8] = t1_8[1];
//     assign s[9] = t1_9[1];
//     assign s[10] = t1_10[1];
//     assign s[11] = t1_11[1];
//     assign s[12] = t1_12[1];
//     assign s[13] = t1_13[1];
//     assign s[14] = t1_14[1];

// endmodule


// /*
// The designers:

// Ahmet Can Mert <ahmetcanmert@sabanciuniv.edu>
// Ferhat Yaman <ferhatyaman@sabanciuniv.edu>

// To the extent possible under law, the implementer has waived all copyright
// and related or neighboring rights to the source code in this file.
// http://creativecommons.org/publicdomain/zero/1.0/
// */

// module dt2(
//     input [2-1:0] t0_0,
//     input [3-1:0] t0_1,
//     input [3-1:0] t0_2,
//     input [3-1:0] t0_3,
//     input [3-1:0] t0_4,
//     input [3-1:0] t0_5,
//     input [3-1:0] t0_6,
//     input [3-1:0] t0_7,
//     input [3-1:0] t0_8,
//     input [2-1:0] t0_9,
//     input [3-1:0] t0_10,
//     input [2-1:0] t0_11,
//     input [2-1:0] t0_12,
//     input [3-1:0] t0_13,
//     input [3-1:0] t0_14,
//     output [15-1:0] s,
//     output [15-1:0] c);

// // ------------------------------- Connections

//     // --------------------- Level 1

//     wire [2-1:0] t1_0;
//     wire [2-1:0] t1_1;
//     wire [2-1:0] t1_2;
//     wire [2-1:0] t1_3;
//     wire [2-1:0] t1_4;
//     wire [2-1:0] t1_5;
//     wire [2-1:0] t1_6;
//     wire [2-1:0] t1_7;
//     wire [2-1:0] t1_8;
//     wire [2-1:0] t1_9;
//     wire [2-1:0] t1_10;
//     wire [2-1:0] t1_11;
//     wire [2-1:0] t1_12;
//     wire [2-1:0] t1_13;
//     wire [2-1:0] t1_14;

// // ------------------------------- Operations

//     // --------------------- Level 1

//     assign t1_0[0] = t0_0[0];
//     assign t1_0[1] = t0_0[1];
//     HA u010(t0_1[0],t0_1[1],t1_2[0],t1_1[0]);
//     assign t1_1[1] = t0_1[2];
//     FA u020(t0_2[0],t0_2[1],t0_2[2],t1_3[0],t1_2[1]);
//     FA u030(t0_3[0],t0_3[1],t0_3[2],t1_4[0],t1_3[1]);
//     FA u040(t0_4[0],t0_4[1],t0_4[2],t1_5[0],t1_4[1]);
//     FA u050(t0_5[0],t0_5[1],t0_5[2],t1_6[0],t1_5[1]);
//     FA u060(t0_6[0],t0_6[1],t0_6[2],t1_7[0],t1_6[1]);
//     FA u070(t0_7[0],t0_7[1],t0_7[2],t1_8[0],t1_7[1]);
//     FA u080(t0_8[0],t0_8[1],t0_8[2],t1_9[0],t1_8[1]);
//     HA u090(t0_9[0],t0_9[1],t1_10[0],t1_9[1]);
//     FA u0100(t0_10[0],t0_10[1],t0_10[2],t1_11[0],t1_10[1]);
//     HA u0110(t0_11[0],t0_11[1],t1_12[0],t1_11[1]);
//     HA u0120(t0_12[0],t0_12[1],t1_13[0],t1_12[1]);
//     FA u0130(t0_13[0],t0_13[1],t0_13[2],t1_14[0],t1_13[1]);
//     FA u0140(t0_14[0],t0_14[1],t0_14[2],dummy_var_0,t1_14[1]);

//     // --------------------- Rewire

//     assign c[0] = t1_0[0];
//     assign c[1] = t1_1[0];
//     assign c[2] = t1_2[0];
//     assign c[3] = t1_3[0];
//     assign c[4] = t1_4[0];
//     assign c[5] = t1_5[0];
//     assign c[6] = t1_6[0];
//     assign c[7] = t1_7[0];
//     assign c[8] = t1_8[0];
//     assign c[9] = t1_9[0];
//     assign c[10] = t1_10[0];
//     assign c[11] = t1_11[0];
//     assign c[12] = t1_12[0];
//     assign c[13] = t1_13[0];
//     assign c[14] = t1_14[0];
//     assign s[0] = t1_0[1];
//     assign s[1] = t1_1[1];
//     assign s[2] = t1_2[1];
//     assign s[3] = t1_3[1];
//     assign s[4] = t1_4[1];
//     assign s[5] = t1_5[1];
//     assign s[6] = t1_6[1];
//     assign s[7] = t1_7[1];
//     assign s[8] = t1_8[1];
//     assign s[9] = t1_9[1];
//     assign s[10] = t1_10[1];
//     assign s[11] = t1_11[1];
//     assign s[12] = t1_12[1];
//     assign s[13] = t1_13[1];
//     assign s[14] = t1_14[1];

// endmodule


// /*
// The designers:

// Ahmet Can Mert <ahmetcanmert@sabanciuniv.edu>
// Ferhat Yaman <ferhatyaman@sabanciuniv.edu>

// To the extent possible under law, the implementer has waived all copyright
// and related or neighboring rights to the source code in this file.
// http://creativecommons.org/publicdomain/zero/1.0/
// */

// module dt3(
//     input [3-1:0] t0_0,
//     input [2-1:0] t0_1,
//     input [2-1:0] t0_2,
//     input [2-1:0] t0_3,
//     input [2-1:0] t0_4,
//     input [2-1:0] t0_5,
//     input [2-1:0] t0_6,
//     input [2-1:0] t0_7,
//     input [3-1:0] t0_8,
//     input [2-1:0] t0_9,
//     input [3-1:0] t0_10,
//     input [3-1:0] t0_11,
//     input [2-1:0] t0_12,
//     input [2-1:0] t0_13,
//     input [2-1:0] t0_14,
//     output [15-1:0] s,
//     output [15-1:0] c);

// // ------------------------------- Connections

//     // --------------------- Level 1

//     wire [2-1:0] t1_0;
//     wire [2-1:0] t1_1;
//     wire [2-1:0] t1_2;
//     wire [2-1:0] t1_3;
//     wire [2-1:0] t1_4;
//     wire [2-1:0] t1_5;
//     wire [2-1:0] t1_6;
//     wire [2-1:0] t1_7;
//     wire [2-1:0] t1_8;
//     wire [2-1:0] t1_9;
//     wire [2-1:0] t1_10;
//     wire [2-1:0] t1_11;
//     wire [2-1:0] t1_12;
//     wire [2-1:0] t1_13;
//     wire [2-1:0] t1_14;

// // ------------------------------- Operations

//     // --------------------- Level 1

//     HA u000(t0_0[0],t0_0[1],t1_1[0],t1_0[0]);
//     assign t1_0[1] = t0_0[2];
//     HA u010(t0_1[0],t0_1[1],t1_2[0],t1_1[1]);
//     HA u020(t0_2[0],t0_2[1],t1_3[0],t1_2[1]);
//     HA u030(t0_3[0],t0_3[1],t1_4[0],t1_3[1]);
//     HA u040(t0_4[0],t0_4[1],t1_5[0],t1_4[1]);
//     HA u050(t0_5[0],t0_5[1],t1_6[0],t1_5[1]);
//     HA u060(t0_6[0],t0_6[1],t1_7[0],t1_6[1]);
//     HA u070(t0_7[0],t0_7[1],t1_8[0],t1_7[1]);
//     FA u080(t0_8[0],t0_8[1],t0_8[2],t1_9[0],t1_8[1]);
//     HA u090(t0_9[0],t0_9[1],t1_10[0],t1_9[1]);
//     FA u0100(t0_10[0],t0_10[1],t0_10[2],t1_11[0],t1_10[1]);
//     FA u0110(t0_11[0],t0_11[1],t0_11[2],t1_12[0],t1_11[1]);
//     HA u0120(t0_12[0],t0_12[1],t1_13[0],t1_12[1]);
//     HA u0130(t0_13[0],t0_13[1],t1_14[0],t1_13[1]);
//     HA u0140(t0_14[0],t0_14[1],dummy_var_0,t1_14[1]);

//     // --------------------- Rewire

//     assign c[0] = t1_0[0];
//     assign c[1] = t1_1[0];
//     assign c[2] = t1_2[0];
//     assign c[3] = t1_3[0];
//     assign c[4] = t1_4[0];
//     assign c[5] = t1_5[0];
//     assign c[6] = t1_6[0];
//     assign c[7] = t1_7[0];
//     assign c[8] = t1_8[0];
//     assign c[9] = t1_9[0];
//     assign c[10] = t1_10[0];
//     assign c[11] = t1_11[0];
//     assign c[12] = t1_12[0];
//     assign c[13] = t1_13[0];
//     assign c[14] = t1_14[0];
//     assign s[0] = t1_0[1];
//     assign s[1] = t1_1[1];
//     assign s[2] = t1_2[1];
//     assign s[3] = t1_3[1];
//     assign s[4] = t1_4[1];
//     assign s[5] = t1_5[1];
//     assign s[6] = t1_6[1];
//     assign s[7] = t1_7[1];
//     assign s[8] = t1_8[1];
//     assign s[9] = t1_9[1];
//     assign s[10] = t1_10[1];
//     assign s[11] = t1_11[1];
//     assign s[12] = t1_12[1];
//     assign s[13] = t1_13[1];
//     assign s[14] = t1_14[1];

// endmodule

// /*
// The designers:

// Ahmet Can Mert <ahmetcanmert@sabanciuniv.edu>
// Ferhat Yaman <ferhatyaman@sabanciuniv.edu>

// To the extent possible under law, the implementer has waived all copyright
// and related or neighboring rights to the source code in this file.
// http://creativecommons.org/publicdomain/zero/1.0/
// */

// module HA(input a,b,
//           output c,s);
//     assign {c,s} = a+b;
// endmodule


// /*
// The designers:

// Ahmet Can Mert <ahmetcanmert@sabanciuniv.edu>
// Ferhat Yaman <ferhatyaman@sabanciuniv.edu>

// To the extent possible under law, the implementer has waived all copyright
// and related or neighboring rights to the source code in this file.
// http://creativecommons.org/publicdomain/zero/1.0/
// */

// module FA(input a,b,cin,
//           output c,s);
//     assign {c,s} = a+b+cin;
// endmodule