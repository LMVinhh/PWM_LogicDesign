module PWM_Nhom3
(
input clk,
input inc_5, // Tang 5% cho duty
input dec_5, // Giam 5% cho duty
output OUT,
output out_r,
output out_g,
output out_b
);
 
reg [6:0] duty = 30; // Duty ban dau la 30%
reg [6:0] duty_r;
reg [6:0] duty_g;
reg [6:0] duty_b;
reg[6:0] counter = 0;
wire tmp1,tmp2, inc;
wire tmp3,tmp4, dec;

// NUT NHAN inc_5 & dec_5
DFF DFF1(clk,inc_5,tmp1);
DFF DFF2(clk,tmp1, tmp2); 
assign inc =  tmp1 & (~ tmp2);

DFF DFF3(clk, dec_5, tmp3);
DFF DFF4(clk, tmp3, tmp4); 
assign dec =  tmp3 & (~ tmp4);

always @(posedge clk)
begin
    if(inc == 1 && duty <= 95) 
        duty <= duty + 5;
    else if(dec == 1 && duty >= 5) 
        duty <= duty - 5;
    case (duty)
                0: begin
                    duty_r = 0; duty_g = 0; duty_b = 0;
                end
                5: begin
                    duty_r = 100; duty_g = 0; duty_b = 0;
                end
                10: begin
                    duty_r = 100; duty_g = 40; duty_b = 0;
                end
                15: begin
                    duty_r = 100; duty_g = 75; duty_b = 0;
                end
                20: begin
                    duty_r = 100; duty_g = 100; duty_b = 0;
                end
                25: begin
                    duty_r = 75; duty_g = 100; duty_b = 0;
                end
                30: begin
                    duty_r = 40; duty_g = 100; duty_b = 0;
                end
                35: begin
                    duty_r = 0; duty_g = 100; duty_b = 0;
                end
                40: begin
                    duty_r = 0; duty_g = 100; duty_b = 40;
                end
                45: begin
                    duty_r = 0; duty_g = 100; duty_b = 75;
                end
                50: begin
                    duty_r = 0; duty_g = 100; duty_b = 100;
                end
                55: begin
                    duty_r = 0; duty_g = 75; duty_b = 100;
                end
                60: begin
                    duty_r = 0; duty_g = 40; duty_b = 100;
                end
                65: begin
                    duty_r = 0; duty_g = 0; duty_b = 100;
                end
                70: begin
                    duty_r = 40; duty_g = 0; duty_b = 100;
                end
                75: begin
                    duty_r = 75; duty_g = 0; duty_b = 100;
                end
                80: begin
                    duty_r = 100; duty_g = 0; duty_b = 100;
                end
                85: begin
                    duty_r = 100; duty_g = 0; duty_b = 75;
                end
                90: begin
                    duty_r = 100; duty_g = 0; duty_b = 40;
                end
                95: begin
                    duty_r = 100; duty_g = 0; duty_b = 0;
                end
                100: begin
                    duty_r = 100; duty_g = 100; duty_b = 100;
                end
            endcase;
end

// count va OUT
always @(posedge clk)
begin
   counter <= counter + 5;
   if(counter >= 95) 
    counter <= 0;
end
assign OUT = (counter < duty) ? 1:0;
assign out_r = (counter < duty_r) ? 1:0;
assign out_g = (counter < duty_g) ? 1:0;
assign out_b = (counter < duty_b) ? 1:0;


endmodule

// D-Flip Flop module
module DFF(clk,D,Q);
input clk,D;
output reg Q;
always @(posedge clk)
begin 
  Q <= D;
end 
endmodule