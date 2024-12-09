module PIPE#(
    parameter  PARA_D_NUM=32
)(
    input clk,
    input rst,
    input mode, //提前设定，在rst上升沿之前
    input en,
    input [11:0] i1,
    input [11:0] i2,
    output [11:0] o1,
    output [11:0] o2
    );
    reg[2:0] pipe_num;
    //ROM
    reg [6:0] w_raddr;
    //BF2
    wire [11:0] BF_w;
    wire [11:0] BF_o1, BF_o2;
    //D
    wire [11:0] D_ntt_1i, D_ntt_1o; //用于ntt的第一个D单元输入输出
    wire [11:0] D_ntt_2i, D_ntt_2o;
    wire [11:0] D_intt_1i, D_intt_1o;
    wire [11:0] D_intt_2i, D_intt_2o;
    //C2
    reg C2_mode;
    wire [11:0] C2_i1, C2_i2, C2_o1, C2_o2;

    // always @(posedge clk or negedge rst) begin
    //     if(!rst) count <= 0;
    //     else begin
    //         if(count==D_NUM*2-1) count<=0;
    //         else count <= count + 1; 
    //     end     
    // end
    reg[5:0] D_NUM;

    // always @(posedge clk or negedge rst) begin
    always @(posedge clk) begin
        if(!rst) begin
            case (PARA_D_NUM)
                32: begin 
                    D_NUM <= (mode==0)?32:1;
                end
                16: begin 
                    D_NUM <= (mode==0)?16:1;
                end
                8: begin 
                    D_NUM <= (mode==0)?8:2;
                end
                4: begin 
                    D_NUM <= (mode==0)?4:4;
                end 
                2: begin 
                    D_NUM <= (mode==0)?2:8;
                end
                1: begin 
                    D_NUM <= (mode==0)?1:16;
                end
                default: ;
            endcase
        end
    end

    reg[6:0] COUNT_START_C2;
    // always @(posedge clk or negedge rst) begin
    always @(posedge clk) begin
        if(!rst) begin
            case (PARA_D_NUM)
                32:begin
                    pipe_num=3'd0;
                    COUNT_START_C2=7;
                end
                16:begin 
                    pipe_num=3'd1;
                    COUNT_START_C2=(mode==0)?(7+32+7):(7+1+7);
                end
                8:begin
                    pipe_num=3'd2;
                    COUNT_START_C2=(mode==0)?(7+32+7+16+7):(7+1+7+2+7);
                end
                4:begin 
                    pipe_num=3'd3;
                    COUNT_START_C2=(mode==0)?(7+32+7+16+7+8+7):(7+1+7+2+7+4+7);
                end
                2:begin
                    pipe_num=3'd4;
                    COUNT_START_C2=(mode==0)?(7+32+7+16+7+8+7+4+7):(7+1+7+2+7+4+7+8+7);
                end
                1:begin 
                    pipe_num=3'd5;
                    COUNT_START_C2=(mode==0)?(7+32+7+16+7+8+7+4+7+2+7):(7+1+7+2+7+4+7+8+7+16+7);
                end
                default: ;
            endcase
        end
    end

    reg [6:0] begin_C2; // 何时启动PE_i的C2
    reg [6:0] begin_BF2; // 何时启动PE_i的BF2,用于循环读取w
    reg [6:0] count_C2; 
    reg [5:0] count_BF2;
    // assign C2_mode = ((count==D_NUM-1) | (count==D_NUM*2-1))?(~C2_mode):C2_mode;
    // always @(posedge clk or negedge rst) begin
    always @(posedge clk) begin
        if(!rst) begin
            begin_C2 <= 0;
            count_C2 <= 0;
            C2_mode <= 0;
        end
        else begin
            if(en==1) begin
                if(begin_C2==COUNT_START_C2) begin //延迟一个BF2(7cc)开启C2反转
                        begin_C2 <= begin_C2;
                        if(mode==0) begin
                            if(count_C2==D_NUM-1) count_C2<=0;
                            else count_C2 <= count_C2 + 1; 
                            if(count_C2==D_NUM-1) C2_mode <= ~C2_mode;
                            else C2_mode <= C2_mode;
                        end
                        else begin
                            //bug
                            if(PARA_D_NUM==32) C2_mode <= ~C2_mode;
                            else begin
                                if(count_C2==2*D_NUM-1) count_C2<=0;
                                else count_C2 <= count_C2 + 1; 
                                if(count_C2==2*D_NUM-1) C2_mode <= ~C2_mode;
                                else C2_mode <= C2_mode;
                            end
                        end
                end
                else begin_C2 <= begin_C2 + 1;
            end
        end
    end
    assign D_ntt_1i = (mode==0)?BF_o2:0;
    assign D_ntt_2i = (mode==0)?C2_o1:0;
    assign D_intt_1i = (mode==0)?0:BF_o2;
    assign D_intt_2i = (mode==0)?0:C2_o1;
    assign C2_i1 = BF_o1;
    assign C2_i2 = (mode==0)?D_ntt_1o:D_intt_1o;
    assign o1 = (mode==0)?D_ntt_2o:D_intt_2o;
    assign o2 = C2_o2;

    // read data from rom
    // always @(posedge clk or negedge rst) begin
    always @(posedge clk) begin
        if(!rst) begin
            begin_BF2 <= 0;
            count_BF2 <= 0;
            case (pipe_num)
                // 3'd0:w_raddr <= (mode==0)?1:127;
                3'd0:w_raddr <= (mode==0)?1:127; //126 for bug
                3'd1:w_raddr <= (mode==0)?2:63;
                3'd2:w_raddr <= (mode==0)?4:31;
                3'd3:w_raddr <= (mode==0)?8:15;
                3'd4:w_raddr <= (mode==0)?16:7;
                3'd5:w_raddr <= (mode==0)?32:3;
                default: w_raddr <= 0;
            endcase
        end
        else begin
            if(en==1) begin
                if(begin_BF2==(COUNT_START_C2-7)) begin
                    if(count_BF2==D_NUM*2-1) count_BF2 <= 0;
                    else count_BF2 <= count_BF2 + 1;
                    begin_BF2 <= begin_BF2;
                    case (pipe_num)
                        3'd0: begin
                            if(mode==0) begin
                                if(w_raddr==1 & count_BF2==D_NUM*2-2) w_raddr <= 1;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr + 1;
                                else w_raddr <= w_raddr;
                            end
                            else begin
                                if(w_raddr==64) w_raddr <= 127;
                                else w_raddr <= w_raddr - 1;
                                // else w_raddr <= w_raddr;
                            end
                        end
                        3'd1:begin
                            if(mode==0) begin
                                if(w_raddr==3 & count_BF2==D_NUM*2-2) w_raddr <= 2;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr + 1;
                                else w_raddr <= w_raddr;
                            end
                            else begin
                                if(w_raddr==32 & count_BF2==D_NUM*2-2) w_raddr <= 63;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr - 1;
                                else w_raddr <= w_raddr;
                            end
                        end
                        3'd2:begin
                            if(mode==0) begin
                                if(w_raddr==7 & count_BF2==D_NUM*2-2) w_raddr <= 4;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr + 1;
                                else w_raddr <= w_raddr;
                            end
                            else begin
                                if(w_raddr==16 & count_BF2==D_NUM*2-2) w_raddr <= 31;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr - 1;
                                else w_raddr <= w_raddr;
                            end
                        end
                        3'd3:begin
                            if(mode==0) begin
                                if(w_raddr==15 & count_BF2==D_NUM*2-2) w_raddr <= 8;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr + 1;
                                else w_raddr <= w_raddr;
                            end
                            else begin
                                if(w_raddr==8 & count_BF2==D_NUM*2-2) w_raddr <= 15;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr - 1;
                                else w_raddr <= w_raddr;
                            end
                        end
                        3'd4:begin
                            if(mode==0) begin
                                if(w_raddr==31 & count_BF2==D_NUM*2-2) w_raddr <= 16;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr + 1;
                                else w_raddr <= w_raddr;
                            end
                            else begin
                                if(w_raddr==4 & count_BF2==D_NUM*2-2) w_raddr <= 7;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr - 1;
                                else w_raddr <= w_raddr;
                            end
                        end
                        3'd5:begin
                            if(mode==0) begin
                                if(w_raddr==63 & count_BF2==D_NUM*2-2) w_raddr <= 32;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr + 1;
                                else w_raddr <= w_raddr;
                            end
                            else begin
                                if(w_raddr==2 & count_BF2==D_NUM*2-2) w_raddr <= 3;
                                else if(count_BF2==D_NUM*2-2)w_raddr <= w_raddr - 1;
                                else w_raddr <= w_raddr;
                            end
                        end 
                        default: w_raddr <= 0;
                    endcase
                end
                else begin 
                    w_raddr <= w_raddr;
                    count_BF2 <= count_BF2;
                    begin_BF2 <= begin_BF2 + 1;
                end
            end
        end
    end

    // wire [11:0] BROM_w;
    // assign BF_w = (rst==0 & mode==1)?2154:BROM_w;
    wire bug;
    assign bug = (mode==1&PARA_D_NUM==32)?1:0; //rst启动后的第一个intt、BF0存在bug
    BROM BROM(clk, w_raddr,BF_w);
    BF BF(bug,clk,rst,mode, en,BF_w, i1, i2, BF_o1, BF_o2);

    D#(PARA_D_NUM) ntt_D1(clk, en,D_ntt_1i, D_ntt_1o);
    D#(PARA_D_NUM) ntt_D2(clk, en,D_ntt_2i, D_ntt_2o);
    D#(32/PARA_D_NUM) intt_D1(clk,en, D_intt_1i, D_intt_1o);
    D#(32/PARA_D_NUM) intt_D2(clk, en,D_intt_2i, D_intt_2o);

    C2 C2(C2_mode, C2_i1, C2_i2, C2_o1, C2_o2);

endmodule




