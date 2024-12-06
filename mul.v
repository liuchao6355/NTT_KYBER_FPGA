// `timescale 1ns / 1ps

// module mul_top(
//     input clk,
//     input [11:0] a,
//     input [11:0] b,
//     output [23:0] c
// );

//     reg [11:0] ai,bi;
//     reg [23:0] ci;
//     wire [23:0] cii;

//     always @(posedge clk) begin
//         ai <= a;
//         bi <= b;
//     end

//     always @(posedge clk) begin
//         ci <= cii+1;
//     end


//     assign c = ci;

//     mul mul(clk, ai,bi,cii);

// endmodule


(*use_dsp="no"*)
module mul(
    input clk,
    input [11:0] a,
    input [11:0] b,
    output [23:0] c
    );
    // reg [23:0] ci;
    // always@(posedge clk) begin 
        // ci <= a*b;
    // end
    assign c = a*b;
    // assign c = ci;

endmodule
