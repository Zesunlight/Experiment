`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:50:15 10/26/2012 
// Design Name: 
// Module Name:    mux2x5 
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
module mux2x5(a0,a1,s,y
    );
	 input [4:0] a0,a1;
	 input s;
	 output [4:0] y;
	 assign y=s?a1:a0;


endmodule
