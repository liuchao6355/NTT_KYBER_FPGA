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
