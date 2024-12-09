// MDC reduce pipeline with en
module reduc(
	input clk,
	input en,
	input [23:0] c,
	output reg [11:0] d,
	output reg [10:0] q
);

wire [11:0] c0;
wire [9:0] c1;
wire [5:0] c2;
wire [3:0] c3;
reg [14:0] c_reg;
reg [12:0] sum;
reg [14:0] p_mux;
reg [14:0] diff;
reg [12:0] diff2;
wire [12:0] diff2p;
reg [10:0] sum_r1, sum_r2, sum_r3;
reg [2:0] delta_r2, delta_r3;
wire [11:0] q_d;

assign c0 = c[23:12];
assign c1 = c[23:14];
assign c2 = c[23:18];
assign c3 = c[23:20];

always @(posedge clk) begin
	if(en==1) begin
		sum <= c0+c1-c2-c3;
		c_reg <= c[14:0];
	end
end
always @(posedge clk) begin
	if(en==1) begin
		diff <= c_reg - sum - {sum[6:0],8'h0} - {sum[4:0],10'h0} - {sum[3:0],11'h0};
		sum_r1 <= sum[10:0];
	end
end

always @* begin
	if(en==1) begin
		case(diff[14:12])
			3'h 0 : p_mux = 0;
			3'h 1 : p_mux = 15'h 72ff;
			3'h 5 : p_mux = 15'h 2703;
			3'h 6 : p_mux = 15'h 2703;
			3'h 7 : p_mux = 15'h 1a02;
			default : p_mux = 0;
		endcase
	end
end
always @(posedge clk) begin
	if(en==1) begin
		diff2 <= diff + p_mux;
		sum_r2 <= sum_r1;
		delta_r2 <= {diff[14],diff[13]&diff[12],diff[13]^diff[12]};
	end
end

assign diff2p = diff2 - 12'h d01;
always @(posedge clk) begin
	if(en==1) begin
		if(diff2p[12])
			d <= diff2;
		else
			d <= diff2p;
		sum_r3 <= sum_r2;
		delta_r3 <= delta_r2 + {2'b0,~diff2p[12]};
	end
end
assign q_d = 12'h 680 - d;
always @(posedge clk) begin
	if(en==1)
		q <= sum_r3 + {{9{delta_r3[2]}},delta_r3[1:0]} + q_d[11];
end
endmodule




// MDC reduce pipeline without en
module reduc2(
	input clk,
	// input en,
	input [23:0] c,
	output reg [11:0] d,
	output reg [10:0] q
);

wire [11:0] c0;
wire [9:0] c1;
wire [5:0] c2;
wire [3:0] c3;
reg [14:0] c_reg;
reg [12:0] sum;
reg [14:0] p_mux;
reg [14:0] diff;
reg [12:0] diff2;
wire [12:0] diff2p;
reg [10:0] sum_r1, sum_r2, sum_r3;
reg [2:0] delta_r2, delta_r3;
wire [11:0] q_d;

assign c0 = c[23:12];
assign c1 = c[23:14];
assign c2 = c[23:18];
assign c3 = c[23:20];

always @(posedge clk) begin
	// if(en==1) begin
		sum <= c0+c1-c2-c3;
		c_reg <= c[14:0];
	// end
end
always @(posedge clk) begin
	// if(en==1) begin
		diff <= c_reg - sum - {sum[6:0],8'h0} - {sum[4:0],10'h0} - {sum[3:0],11'h0};
		sum_r1 <= sum[10:0];
	// end
end

always @* begin
	// if(en==1) begin
		case(diff[14:12])
			3'h 0 : p_mux = 0;
			3'h 1 : p_mux = 15'h 72ff;
			3'h 5 : p_mux = 15'h 2703;
			3'h 6 : p_mux = 15'h 2703;
			3'h 7 : p_mux = 15'h 1a02;
			default : p_mux = 0;
		endcase
	// end
end
always @(posedge clk) begin
	// if(en==1) begin
		diff2 <= diff + p_mux;
		sum_r2 <= sum_r1;
		delta_r2 <= {diff[14],diff[13]&diff[12],diff[13]^diff[12]};
	// end
end

assign diff2p = diff2 - 12'h d01;
always @(posedge clk) begin
	// if(en==1) begin
		if(diff2p[12])
			d <= diff2;
		else
			d <= diff2p;
		sum_r3 <= sum_r2;
		delta_r3 <= delta_r2 + {2'b0,~diff2p[12]};
	// end
end
assign q_d = 12'h 680 - d;
always @(posedge clk) begin
	// if(en==1)
		q <= sum_r3 + {{9{delta_r3[2]}},delta_r3[1:0]} + q_d[11];
end
endmodule






//compress 1cc 
//for compress  24bit/q的结果
module Compress_Mod_reduce(
    // input clk,
    input [23:0] prod, // prod不需要+1664

    // output [_du-1:0] quo
    output [11:0] quo
);
    // assign quo = prod%3329;
    parameter q = 3329;
    reg [12:0] res;
    reg [12:0] reg_quo;
    wire [12:0] reg_quo_temp;
    wire [12:0] reg_quo_temp1,reg_quo_temp2;
    assign reg_quo_temp1 = {1'b0,prod[23:12]} + {1'b0,prod[23:14]};
    assign reg_quo_temp2 = {1'b0,prod[23:18]} + {1'b0,prod[23:20]};
    assign reg_quo_temp = reg_quo_temp1-reg_quo_temp2;


    wire [14:0] reg_diff,reg_diff_temp1,reg_diff_temp2,reg_diff_temp3;
    assign reg_diff_temp1 = reg_quo_temp[3:0]<<11;
    assign reg_diff_temp2 = reg_quo_temp[4:0]<<10;
    assign reg_diff_temp3 = reg_quo_temp[6:0]<<8;
    assign reg_diff = prod[14:0] - (reg_quo_temp + reg_diff_temp1+reg_diff_temp2+reg_diff_temp3); 

    always @(*) begin
        case (reg_diff[14:12])
            3'd0:begin 
                res <= reg_diff;
                reg_quo <= reg_quo_temp;
            end
            3'd1:begin
                res <= reg_diff - q;
                reg_quo <= reg_quo_temp + 1;
            end
            3'd5:begin
                res <= reg_diff + 3*q;
                reg_quo <= reg_quo_temp -3;
            end
            3'd6:begin
                res <= reg_diff + 3*q;
                reg_quo <= reg_quo_temp -3;
            end
            3'd7:begin
                res <= reg_diff + 2*q;
                reg_quo <= reg_quo_temp - 2;
            end
            default:begin
                res <= reg_diff;
                reg_quo <= reg_quo_temp;
            end 
        endcase
    end
    
    wire [12:0] reg_quo2;
    wire [12:0] res_2;
    assign res_2 = res>q?(res-q):res;
    assign reg_quo2 = res>q?(reg_quo+1):reg_quo;

    assign quo = (res_2>(3329>>1))?(reg_quo2+1):reg_quo2;
endmodule   

