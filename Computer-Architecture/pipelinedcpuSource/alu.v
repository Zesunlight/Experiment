`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:43 10/26/2012 
// Design Name: 
// Module Name:    alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu(a,b,aluc,r,z
    );
	 input [31:0] a,b;
	 input [4:0] aluc;
	 output [31:0] r;
	 output z;
	 wire [31:0] d_and=a&b;    
	 wire [31:0] d_or=a|b;

	 wire [31:0] d_xor=a^b;
	 wire [31:0] d_lui={b[15:0],16'h0};
	 
	 wire [31:0] d_and_or=aluc[3]?d_or:d_and;

	 
	 wire [31:0] d_as,d_mul,d_sh;
	 wire [15:0] mul_a=a[15:0];
	 wire [15:0] mul_b=b[15:0];
	 
	 
	 addsub32 as32 (a,b,aluc[3],d_as);//加法器和减法器的结合，根据aluc[3]选择是加法还是减法
	 mul_signed mul16(mul_a,mul_b,d_mul);//乘法器
	 shift shifter (b,a[4:0],aluc[3],aluc[4],d_sh);//移位器
	 mux6x32 select(d_as,d_mul,d_and_or,d_xor,d_lui,d_sh,aluc[2:0],r);//六选一多路选择器选择该做什么运算
	 assign z=~|r;//结果r为0，则z=1
	
endmodule
