`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:48 10/26/2012 
// Design Name: 
// Module Name:    addsub32 
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
module addsub32(a,b,sub,s
    );
	 input [31:0] a,b;
	 input sub;
	 output [31:0] s;
	 cla32 as32 (a,b^{32{sub}},sub,s);

endmodule
