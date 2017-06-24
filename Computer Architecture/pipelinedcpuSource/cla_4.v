`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:44:55 10/25/2012 
// Design Name: 
// Module Name:    cla_4 
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
module cla_4(a,b,c_in,g_out,p_out,s
    );
	 input [3:0] a,b;
	 input c_in;
	 output g_out,p_out;
	 output [3:0] s;
	 wire [1:0] g,p;
	 wire c_out;
	 cla_2 cla0 (a[1:0],b[1:0],c_in,g[0],p[0],s[1:0]);
	 cla_2 cla1 (a[3:2],b[3:2],c_out,g[1],p[1],s[3:2]);
	 g_p g_p0 (g,p,c_in,g_out,p_out,c_out);
   
endmodule
