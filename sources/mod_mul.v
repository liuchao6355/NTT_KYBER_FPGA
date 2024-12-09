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


