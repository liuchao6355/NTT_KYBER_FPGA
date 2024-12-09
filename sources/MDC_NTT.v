
module MDC_NTT(
    input clk,
    input rst,
    input mode,
    input en,
    input [11:0] i1,
    input [11:0] i2,
    output [11:0] o1,
    output [11:0] o2,
    output done
    );

    integer i;
    // (* max_fanout = "15" *) reg [119:0] count;
    reg [119:0] count;
    // fanout 1130
    (* max_fanout = 5 *) reg reg_count111;
    (* max_fanout = 5 *) reg reg_count117;
    always @(posedge clk) begin
        if(!rst) begin
            for (i=0; i<119 ;i=i+1 ) begin
                count[i] <= 0;
            end
            reg_count111 <= 0;
            reg_count117 <= 0;
        end
        else begin
            if(mode==0) begin
                count[0] <= en;
                for (i=0; i<110; i=i+1) begin
                    count[i+1] <= count[i];
                end
                reg_count111 <= count[110];
            end
            else begin
                count[0] <= en;
                for (i=0; i<116; i=i+1) begin
                    count[i+1] <= count[i];
                end
                reg_count117 <= count[116];
            end
        end
    end
    // assign done = (mode==0)?count[111]:count[117];
    assign done = (mode==0)?reg_count111:reg_count117;

    wire [11:0] pipe0_o1, pipe0_o2;
    PIPE#(32) PIPE0(clk, rst, mode, en|done,i1, i2, pipe0_o1, pipe0_o2);
    
    assign pipe1_i1 = pipe0_o1;
    assign pipe1_i2 = pipe0_o2;

    wire [11:0] pipe1_i1,pipe1_i2, pipe1_o1, pipe1_o2;
    PIPE#(16) PIPE1(clk, rst, mode, en|done,pipe1_i1, pipe1_i2, pipe1_o1, pipe1_o2);

    assign pipe2_i1 = pipe1_o1;
    assign pipe2_i2 = pipe1_o2;

    wire [11:0] pipe2_i1,pipe2_i2, pipe2_o1, pipe2_o2;
    PIPE#(8) PIPE2(clk, rst, mode, en|done,pipe2_i1, pipe2_i2, pipe2_o1, pipe2_o2);

    assign pipe3_i1 = pipe2_o1;
    assign pipe3_i2 = pipe2_o2;

    wire [11:0] pipe3_i1,pipe3_i2, pipe3_o1, pipe3_o2;
    PIPE#(4) PIPE3(clk, rst, mode,en|done, pipe3_i1, pipe3_i2, pipe3_o1, pipe3_o2);

    assign pipe4_i1 = pipe3_o1;
    assign pipe4_i2 = pipe3_o2;

    wire [11:0] pipe4_i1,pipe4_i2, pipe4_o1, pipe4_o2;
    PIPE#(2) PIPE4(clk, rst, mode,en|done, pipe4_i1, pipe4_i2, pipe4_o1, pipe4_o2);

    assign pipe5_i1 = pipe4_o1;
    assign pipe5_i2 = pipe4_o2;

    wire [11:0] pipe5_i1,pipe5_i2, pipe5_o1, pipe5_o2;
    PIPE#(1) PIPE5(clk, rst, mode,en|done, pipe5_i1, pipe5_i2, pipe5_o1, pipe5_o2);

    assign pipeEND_i1 = pipe5_o1;
    assign pipeEND_i2 = pipe5_o2;
    
    wire [11:0] pipeEND_i1, pipeEND_i2;
    PIPE_END PIPE_END(clk, rst, mode,en|done, pipeEND_i1, pipeEND_i2, o1, o2);

    // assign o1 = pipe5_o1;
    // assign o2 = pipe5_o2;

endmodule

