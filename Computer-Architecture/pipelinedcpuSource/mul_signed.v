`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:47:59 10/31/2012 
// Design Name: 
// Module Name:    mul_signed 
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
module mul_signed(a,b,z
    );
	 input [15:0] a,b;
	 output [31:0] z;
	 wire [15:0] ab0 = b[0]?a:16'b0;
	 wire [15:0] ab1 = b[1]?a:16'b0;
    wire [15:0] ab2 = b[2]?a:16'b0;
	 wire [15:0] ab3 = b[3]?a:16'b0;
	 wire [15:0] ab4 = b[4]?a:16'b0;
	 wire [15:0] ab5 = b[5]?a:16'b0;
    wire [15:0] ab6 = b[6]?a:16'b0;
	 wire [15:0] ab7 = b[7]?a:16'b0;
	 wire [15:0] ab8 = b[8]?a:16'b0;
	 wire [15:0] ab9 = b[9]?a:16'b0;
    wire [15:0] ab10 = b[10]?a:16'b0;
	 wire [15:0] ab11 = b[11]?a:16'b0;
	 wire [15:0] ab12 = b[12]?a:16'b0;
	 wire [15:0] ab13 = b[13]?a:16'b0;
    wire [15:0] ab14 = b[14]?a:16'b0;
	 wire [15:0] ab15 = b[15]?a:16'b0;
	 assign z=((({16'b1,~ab0[15],ab0[14:0]}+
	             {15'b0,~ab1[15],ab1[14:0],1'b0})+
					({14'b0,~ab2[15],ab2[14:0],2'b0}+
					 {13'b0,~ab3[15],ab3[14:0],3'b0}))+
				  (({12'b0,~ab4[15],ab4[14:0],4'b0}+
					 {11'b0,~ab5[15],ab5[14:0],5'b0})+
					({10'b0,~ab6[15],ab6[14:0],6'b0}+
					 {9'b0,~ab7[15],ab7[14:0],7'b0})))+
				 ((({8'b0,~ab8[15],ab8[14:0],8'b0}+
					 {7'b0,~ab9[15],ab9[14:0],9'b0})+
					({6'b0,~ab10[15],ab10[14:0],10'b0}+
					 {5'b0,~ab11[15],ab11[14:0],11'b0}))+
				  (({4'b0,~ab12[15],ab12[14:0],12'b0}+
					 {3'b0,~ab13[15],ab13[14:0],13'b0})+
					({2'b0,~ab14[15],ab14[14:0],14'b0}+
					 {1'b1,ab15[15],~ab15[14:0],15'b0})));


endmodule
