`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:12 10/25/2012 
// Design Name: 
// Module Name:    cla_32 
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
module cla_32(a,b,c_in,g_out,p_out,s
    );
	 input [31:0] a,b;
	 input c_in;
	 output g_out,p_out;
	 output [31:0] s;
	 wire [1:0] g,p;
	 wire c_out;
	 cla_16 cla0 (a[15:0],b[15:0],c_in,g[0],p[0],s[15:0]);
	 cla_16 cla1 (a[31:16],b[31:16],c_out,g[1],p[1],s[31:16]);
	 g_p g_p0 (g,p,c_in,g_out,p_out,c_out);
endmodule
