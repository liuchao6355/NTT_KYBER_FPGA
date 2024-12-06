module BROM(
    input clk,
    input [6:0] raddr,
    output [11:0] w
    );
    (* ram_style="distributed"*) reg [11:0] Mem_w[0:127];
    reg [11:0] reg_w;
    always @(posedge clk) begin
        reg_w <= Mem_w[raddr];
    end
    assign w = reg_w;

     initial begin
        Mem_w[0] = 12'd1;
        Mem_w[1] = 12'd1729;
        Mem_w[2] = 12'd2580;
        Mem_w[3] = 12'd3289;
        Mem_w[4] = 12'd2642;
        Mem_w[5] = 12'd630;
        Mem_w[6] = 12'd1897;
        Mem_w[7] = 12'd848;
        Mem_w[8] = 12'd1062;
        Mem_w[9] = 12'd1919;
        Mem_w[10] = 12'd193;
        Mem_w[11] = 12'd797;
        Mem_w[12] = 12'd2786;
        Mem_w[13] = 12'd3260;
        Mem_w[14] = 12'd569;
        Mem_w[15] = 12'd1746;
        Mem_w[16] = 12'd296;
        Mem_w[17] = 12'd2447;
        Mem_w[18] = 12'd1339;
        Mem_w[19] = 12'd1476;
        Mem_w[20] = 12'd3046;
        Mem_w[21] = 12'd56;
        Mem_w[22] = 12'd2240;
        Mem_w[23] = 12'd1333;
        Mem_w[24] = 12'd1426;
        Mem_w[25] = 12'd2094;
        Mem_w[26] = 12'd535;
        Mem_w[27] = 12'd2882;
        Mem_w[28] = 12'd2393;
        Mem_w[29] = 12'd2879;
        Mem_w[30] = 12'd1974;
        Mem_w[31] = 12'd821;
        Mem_w[32] = 12'd289;
        Mem_w[33] = 12'd331;
        Mem_w[34] = 12'd3253;
        Mem_w[35] = 12'd1756;
        Mem_w[36] = 12'd1197;
        Mem_w[37] = 12'd2304;
        Mem_w[38] = 12'd2277;
        Mem_w[39] = 12'd2055;
        Mem_w[40] = 12'd650;
        Mem_w[41] = 12'd1977;
        Mem_w[42] = 12'd2513;
        Mem_w[43] = 12'd632;
        Mem_w[44] = 12'd2865;
        Mem_w[45] = 12'd33;
        Mem_w[46] = 12'd1320;
        Mem_w[47] = 12'd1915;
        Mem_w[48] = 12'd2319;
        Mem_w[49] = 12'd1435;
        Mem_w[50] = 12'd807;
        Mem_w[51] = 12'd452;
        Mem_w[52] = 12'd1438;
        Mem_w[53] = 12'd2868;
        Mem_w[54] = 12'd1534;
        Mem_w[55] = 12'd2402;
        Mem_w[56] = 12'd2647;
        Mem_w[57] = 12'd2617;
        Mem_w[58] = 12'd1481;
        Mem_w[59] = 12'd648;
        Mem_w[60] = 12'd2474;
        Mem_w[61] = 12'd3110;
        Mem_w[62] = 12'd1227;
        Mem_w[63] = 12'd910;
        Mem_w[64] = 12'd17;
        Mem_w[65] = 12'd2761;
        Mem_w[66] = 12'd583;
        Mem_w[67] = 12'd2649;
        Mem_w[68] = 12'd1637;
        Mem_w[69] = 12'd723;
        Mem_w[70] = 12'd2288;
        Mem_w[71] = 12'd1100;
        Mem_w[72] = 12'd1409;
        Mem_w[73] = 12'd2662;
        Mem_w[74] = 12'd3281;
        Mem_w[75] = 12'd233;
        Mem_w[76] = 12'd756;
        Mem_w[77] = 12'd2156;
        Mem_w[78] = 12'd3015;
        Mem_w[79] = 12'd3050;
        Mem_w[80] = 12'd1703;
        Mem_w[81] = 12'd1651;
        Mem_w[82] = 12'd2789;
        Mem_w[83] = 12'd1789;
        Mem_w[84] = 12'd1847;
        Mem_w[85] = 12'd952;
        Mem_w[86] = 12'd1461;
        Mem_w[87] = 12'd2687;
        Mem_w[88] = 12'd939;
        Mem_w[89] = 12'd2308;
        Mem_w[90] = 12'd2437;
        Mem_w[91] = 12'd2388;
        Mem_w[92] = 12'd733;
        Mem_w[93] = 12'd2337;
        Mem_w[94] = 12'd268;
        Mem_w[95] = 12'd641;
        Mem_w[96] = 12'd1584;
        Mem_w[97] = 12'd2298;
        Mem_w[98] = 12'd2037;
        Mem_w[99] = 12'd3220;
        Mem_w[100] = 12'd375;
        Mem_w[101] = 12'd2549;
        Mem_w[102] = 12'd2090;
        Mem_w[103] = 12'd1645;
        Mem_w[104] = 12'd1063;
        Mem_w[105] = 12'd319;
        Mem_w[106] = 12'd2773;
        Mem_w[107] = 12'd757;
        Mem_w[108] = 12'd2099;
        Mem_w[109] = 12'd561;
        Mem_w[110] = 12'd2466;
        Mem_w[111] = 12'd2594;
        Mem_w[112] = 12'd2804;
        Mem_w[113] = 12'd1092;
        Mem_w[114] = 12'd403;
        Mem_w[115] = 12'd1026;
        Mem_w[116] = 12'd1143;
        Mem_w[117] = 12'd2150;
        Mem_w[118] = 12'd2775;
        Mem_w[119] = 12'd886;
        Mem_w[120] = 12'd1722;
        Mem_w[121] = 12'd1212;
        Mem_w[122] = 12'd1874;
        Mem_w[123] = 12'd1029;
        Mem_w[124] = 12'd2110;
        Mem_w[125] = 12'd2935;
        Mem_w[126] = 12'd885;
        Mem_w[127] = 12'd2154;

    end

endmodule




module BROM_PWM(
    input clk,
    input [5:0] raddr,
    output [23:0] w
    );
    (* ram_style="distributed"*) reg [23:0] Mem_w[0:63];
    reg [23:0] reg_w;
    always @(posedge clk) begin
        reg_w <= Mem_w[raddr];
    end
    assign w = reg_w;
    // assign w = Mem_w[raddr];

     initial begin
        Mem_w[0] = 24'h011CF0;
        Mem_w[1] = 24'hAC9238;
        Mem_w[2] = 24'h247ABA;
        Mem_w[3] = 24'hA592A8;
        Mem_w[4] = 24'h66569C;
        Mem_w[5] = 24'h2D3A2E;
        Mem_w[6] = 24'h8F0411;
        Mem_w[7] = 24'h44C8B5;
        Mem_w[8] = 24'h581780;
        Mem_w[9] = 24'hA6629B;
        Mem_w[10] = 24'hCD1030;
        Mem_w[11] = 24'h0E9C18;
        Mem_w[12] = 24'h2F4A0D;
        Mem_w[13] = 24'h86C495;
        Mem_w[14] = 24'hBC713A;
        Mem_w[15] = 24'hBEA117;
        Mem_w[16] = 24'h6A765A;
        Mem_w[17] = 24'h67368E;
        Mem_w[18] = 24'hAE521C;
        Mem_w[19] = 24'h6FD604;
        Mem_w[20] = 24'h7375CA;
        Mem_w[21] = 24'h3B8949;
        Mem_w[22] = 24'h5B574C;
        Mem_w[23] = 24'hA7F282;
        Mem_w[24] = 24'h3AB956;
        Mem_w[25] = 24'h9043FD;
        Mem_w[26] = 24'h98537C;
        Mem_w[27] = 24'h9543AD;
        Mem_w[28] = 24'h2DDA24;
        Mem_w[29] = 24'h9213E0;
        Mem_w[30] = 24'h10CBF5;
        Mem_w[31] = 24'h281A80;
        Mem_w[32] = 24'h6306D1;
        Mem_w[33] = 24'h8FA407;
        Mem_w[34] = 24'h7F550C;
        Mem_w[35] = 24'hC9406D;
        Mem_w[36] = 24'h177B8A;
        Mem_w[37] = 24'h9F530C;
        Mem_w[38] = 24'h82A4D7;
        Mem_w[39] = 24'h66D694;
        Mem_w[40] = 24'h4278DA;
        Mem_w[41] = 24'h13FBC2;
        Mem_w[42] = 24'hAD522C;
        Mem_w[43] = 24'h2F5A0C;
        Mem_w[44] = 24'h8334CE;
        Mem_w[45] = 24'h231AD0;
        Mem_w[46] = 24'h9A235F;
        Mem_w[47] = 24'hA222DF;
        Mem_w[48] = 24'hAF420D;
        Mem_w[49] = 24'h4448BD;
        Mem_w[50] = 24'h193B6E;
        Mem_w[51] = 24'h4028FF;
        Mem_w[52] = 24'h47788A;
        Mem_w[53] = 24'h86649B;
        Mem_w[54] = 24'hAD722A;
        Mem_w[55] = 24'h37698B;
        Mem_w[56] = 24'h6BA647;
        Mem_w[57] = 24'h4BC845;
        Mem_w[58] = 24'h7525AF;
        Mem_w[59] = 24'h4058FC;
        Mem_w[60] = 24'h83E4C3;
        Mem_w[61] = 24'hB7718A;
        Mem_w[62] = 24'h37598C;
        Mem_w[63] = 24'h86A497;

    end

endmodule
