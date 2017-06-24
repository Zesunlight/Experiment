`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:42:26 10/25/2012 
// Design Name: 
// Module Name:    cla_8 
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
module cla_8(a,b,c_in,g_out,p_out,s
    );
	 input [7:0] a,b;
	 input c_in;
	 output g_out,p_out;
	 output [7:0] s;
	 wire [1:0] g,p;
	 wire c_out;
	 cla_4 cla0 (a[3:0],b[3:0],c_in,g[0],p[0],s[3:0]);
	 cla_4 cla1 (a[7:4],b[7:4],c_out,g[1],p[1],s[7:4]);
	 g_p g_p0 (g,p,c_in,g_out,p_out,c_out);

endmodule
