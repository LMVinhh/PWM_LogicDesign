`timescale 1ns / 1ps
module tb_PWM_Nhom3;
reg clk;
reg inc_5;
reg dec_5;
wire OUT;
wire out_r;
wire out_g;
wire out_b;

PWM_Nhom3 uut(
.clk(clk), 
.inc_5(inc_5), 
.dec_5(dec_5), 
.OUT(OUT),
.out_r(out_r),
.out_g(out_g),
.out_b(out_b)
);

initial $monitor("time %t: dec = %b, inc = %b, OUT = %d, , Red = %d, Green = %d, Blue = %d", $time, dec_5, inc_5, OUT, out_r, out_g, out_b);
always #1 clk = ~clk;

initial begin // Shows 30 - 50 - 90 - 65 - 20 duty
    clk = 1;
    inc_5 = 0; // 30% 
    dec_5 = 0;
    #140; 
    inc_5 = 1; #3; // 35%
    inc_5 = 0; #3;
    inc_5 = 1; #3; // 40%
    inc_5 = 0; #3;
    inc_5 = 1; #3; // 45%
    inc_5 = 0; #3;
    inc_5 = 1; #3; // 50%
    inc_5 = 0; #3;
    #140;
    inc_5 = 1; #3; // 55%
    inc_5 = 0; #3;
    inc_5 = 1; #3; // 60%
    inc_5 = 0; #3;
    inc_5 = 1; #3; // 65%
    inc_5 = 0; #3;
    inc_5 = 1; #3; // 70%
    inc_5 = 0; #3;
    inc_5 = 1; #3; // 75%
    inc_5 = 0; #3;
    inc_5 = 1; #3; // 80%
    inc_5 = 0; #3;
    inc_5 = 1; #3; // 85%
    inc_5 = 0; #3;
    inc_5 = 1; #3; // 90%
    inc_5 = 0; #3;
    #140;
    dec_5 = 1; #3; // 85%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 80%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 75%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 70%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 65%
    dec_5 = 0; #3;
    #140;
    dec_5 = 1; #3; // 60%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 55%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 50%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 45%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 40%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 35%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 30%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 25%
    dec_5 = 0; #3;
    dec_5 = 1; #3; // 20%
    dec_5 = 0; #3;
    #140;
end
endmodule