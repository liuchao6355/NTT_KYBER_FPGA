# NTT_KYBER_FPGA

$Z_q[x] / (x^{256}+1) \quad q=3329$

Implementing a seven stage pipeline MDC-NTT using Verilog for q=3329, n=256.  

##### Clock Cycle

Complete the first polynomial NTT operation in 112+128 cc, and continuously input subsequent polynomials consume 128 cc to complete the NTT operation.

For intt, use 119+128 cc.

##### Resources

Using 3800 LUTs and 2500 FFs

