`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:47:03 10/25/2012 
// Design Name: 
// Module Name:    cla_2 
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
module cla_2(a,b,c_in,g_out,p_out,s
    );
	 input [1:0] a,b;
	 input c_in;
	 output g_out,p_out;
	 output [1:0] s;
	 wire [1:0] g,p;
	 wire c_out;
	 add add0 (a[0],b[0],c_in,g[0],p[0],s[0]);
	 add add1 (a[1],b[1],c_out,g[1],p[1],s[1]);
	 g_p g_p0 (g,p,c_in,g_out,p_out,c_out);
endmodule
