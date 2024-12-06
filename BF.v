module BF(
    input bug,//对于intt的BF1，MUL输入w，intt其他BF输入reg_w
    input clk,
    input rst,
    input mode, //0 for ntt, 1 for intt
    input en,
    input [11:0] w,
    input [11:0] i1,
    input [11:0] i2,
    output [11:0] o1,
    output [11:0] o2
    );
    reg [11:0] add_sub1, add_sub2;
    wire [11:0] add_tmp, sub_tmp;
    reg [11:0] mul1,mul2;
    wire [11:0] mul_tmp;
    reg [11:0] tmp_w;
    

    reg [11:0] tmp0,tmp1,tmp2,tmp3,tmp4,tmp5;


    always @(posedge clk or negedge rst) begin
    // always @(posedge clk) begin
        if(!rst) begin

        end
        else begin
            if(en==1) begin
                if(mode==0) begin
                    mul1 <= i2;
                    mul2 <= w; 
                    add_sub1 <= tmp5;
                    add_sub2 <= mul_tmp;
                end
                else begin
                    add_sub1 <= i2;
                    add_sub2 <= i1;
                    // mul1 <= tmp_w;
                    mul1 <= (bug==1)?w:tmp_w;
                    mul2 <= sub_tmp;
                end
            end
        end
    end
    assign o1 = (mode==0)?add_tmp:tmp5;
    assign o2 = (mode==0)?sub_tmp:mul_tmp;

    always @(posedge clk or negedge rst) begin
    // always @(posedge clk) begin
        if(!rst) tmp_w <= 0;
        else begin
            if(en==1) tmp_w <= w;
        end
        // tmp_w <= w;
    end

    always @(posedge clk  or negedge rst) begin
    // always @(posedge clk) begin
        if(!rst) begin
            tmp0 <= 0;
            tmp1 <= 0;
            tmp2 <= 0;
            tmp3 <= 0;
            tmp4 <= 0;
            tmp5 <= 0;
        end
        else begin
            if(en==1) begin
                if(mode==0) begin
                    tmp0 <= i1;
                    tmp1 <= tmp0;
                    tmp2 <= tmp1;
                    tmp3 <= tmp2;
                    tmp4 <= tmp3;
                    tmp5 <= tmp4;
                end
                else begin
                    tmp0 <= add_tmp;
                    tmp1 <= tmp0;
                    tmp2 <= tmp1;
                    tmp3 <= tmp2;
                    tmp4 <= tmp3;
                    tmp5 <= tmp4;
                end
            end
        end
    end

    modadd modadd(add_sub1, add_sub2, add_tmp);
    modsub modsub(add_sub1, add_sub2, sub_tmp);

    modmul modmul(clk, en,mul1, mul2, mul_tmp);

endmodule
