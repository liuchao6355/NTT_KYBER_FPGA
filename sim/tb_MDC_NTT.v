module tb_MDC_NTT();
    reg clk, rst, mode,en;
    reg [11:0] i1,i2;
    wire [11:0] o1, o2;
    reg [11:0] din[0:255];
    reg [11:0] din2[0:255];
    wire done;
    initial begin
        $readmemh("ntt_coeff.txt",din);
        $readmemh("intt_coeff.txt",din2);
    end
    integer i;
    always #5 clk = ~clk;
    initial begin
        // #5;
        clk = 0;
      
        mode =0;
        rst = 0;
        en=0;
        #25;
        rst = 1;
        // #100; //可有可无
        en = 1;
        // #10;
        //poly1
        for (i = 0; i< 128; i=i+2) begin
            i1 = din[i];
            i2 = din[i+128];
            #10;
        end
        for (i = 1; i< 128; i=i+2) begin
            i1 = din[i];
            i2 = din[i+128];
            #10;
        end
        // //poly2
        // for (i = 0; i< 128; i=i+2) begin
        //     i1 = din[i];
        //     i2 = din[i+128];
        //     #10;
        // end
        // for (i = 1; i< 128; i=i+2) begin
        //     i1 = din[i];
        //     i2 = din[i+128];
        //     #10;
        // end
        en = 0;
        i1 = 0;
        i2 = 0;
        #2000;
        // //intt
        mode = 1;
        rst = 0;
        en = 0;
        #10; 
        rst = 1;
        en = 1;
        for (i = 0; i< 256; i=i+4) begin
            i1 = din2[i];
            i2 = din2[i+2];
            #10;
        end
        for (i = 1; i< 256; i=i+4) begin
            i1 = din2[i];
            i2 = din2[i+2];
            #10;
        end
        //poly2
        // for (i = 0; i< 256; i=i+4) begin
        //     i1 = din2[i];
        //     i2 = din2[i+2];
        //     #10;
        // end
        // for (i = 1; i< 256; i=i+4) begin
        //     i1 = din2[i];
        //     i2 = din2[i+2];
        //     #10;
        // end
        en = 0;
        i1 = 0;
        i2 = 0;

    end 

    MDC_NTT MDC_NTT(clk, rst, mode, en,i1, i2, o1, o2,done);

endmodule
