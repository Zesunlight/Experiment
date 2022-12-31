`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:23:11 10/29/2012 
// Design Name: 
// Module Name:    IP_ROM 
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
module IP_ROM(a,inst
    );
	 input [31:0] a;
	 output [31:0] inst;
	 wire [31:0] rom [0:63];
	 
	 assign rom[6'h00]=32'h44000001;//lui r1,0
	 assign rom[6'h01]=32'h28014024;//ori r4,r1,80
	 assign rom[6'h02]=32'h00202124;//sub r8,r9,r4
	 assign rom[6'h03]=32'h14001005;//addi r5,r0,4
	 assign rom[6'h04]=32'h38000082;//store r2,0x0(r4)
	 assign rom[6'h05]=32'h34000089;//load r9,0x0(r4)
	 assign rom[6'h06]=32'h00000000;
	 assign rom[6'h07]=32'h00000000;
	 assign rom[6'h08]=32'h00000000;
	 assign rom[6'h09]=32'h00000000;
	 assign rom[6'h0A]=32'h00000000;
	 assign rom[6'h0B]=32'h00000000;
	 assign rom[6'h0C]=32'h00000000;
	 assign rom[6'h0D]=32'h00000000;
	 assign rom[6'h0E]=32'h00000000;
	 assign rom[6'h0F]=32'h00000000;
	 assign rom[6'h10]=32'h00000000;
	 assign rom[6'h11]=32'h00000000;
	 assign rom[6'h12]=32'h00000000;
	 assign rom[6'h13]=32'h00000000;
	 assign rom[6'h14]=32'h00000000;
	 assign rom[6'h15]=32'h00000000;
	 assign rom[6'h16]=32'h00000000;
	 assign rom[6'h17]=32'h00000000;
	 assign rom[6'h18]=32'h00000000;
	 assign rom[6'h19]=32'h00000000;
	 assign rom[6'h1A]=32'h00000000;
	 assign rom[6'h1B]=32'h00000000;
	 assign rom[6'h1C]=32'h00000000;
	 assign rom[6'h1D]=32'h00000000;
	 assign rom[6'h1E]=32'h00000000;
	 assign rom[6'h1F]=32'h00000000;
	 assign rom[6'h20]=32'h00000000;
	 assign rom[6'h21]=32'h00000000;
	 assign rom[6'h22]=32'h00000000;
	 
	 assign rom[6'h23]=32'h00000000;
	 assign rom[6'h24]=32'h00000000;
	 assign rom[6'h25]=32'h00000000;
	 assign rom[6'h26]=32'h00000000;
	 assign rom[6'h27]=32'h00000000;
	 assign rom[6'h28]=32'h00000000;
	 assign rom[6'h29]=32'h00000000;
	 assign rom[6'h2A]=32'h00000000;
	 assign rom[6'h2B]=32'h00000000;
	 assign rom[6'h2C]=32'h00000000;
	 assign rom[6'h2D]=32'h00000000;
	 assign rom[6'h2E]=32'h00000000;
	 assign rom[6'h2F]=32'h00000000;
	 assign rom[6'h30]=32'h00000000;
	 assign rom[6'h31]=32'h00000000;
	 assign rom[6'h32]=32'h00000000;
	 assign rom[6'h33]=32'h00000000;
	 assign rom[6'h34]=32'h00000000;
	 assign rom[6'h35]=32'h00000000;
	 assign rom[6'h36]=32'h00000000;
	 assign rom[6'h37]=32'h00000000;
	 assign rom[6'h38]=32'h00000000;
	 assign rom[6'h39]=32'h00000000;
	 assign rom[6'h3A]=32'h00000000;
	 assign rom[6'h3B]=32'h00000000;
	 assign rom[6'h3C]=32'h00000000;
	 assign rom[6'h3D]=32'h00000000;
	 assign rom[6'h3E]=32'h00000000;
	 assign rom[6'h3F]=32'h00000000;
	 
	 assign inst=rom[a[7:2]];
endmodule
