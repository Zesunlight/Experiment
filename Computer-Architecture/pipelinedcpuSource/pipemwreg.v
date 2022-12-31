`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:14:19 10/26/2012 
// Design Name: 
// Module Name:    pipemwreg 
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
module pipemwreg(mwreg,mm2reg,mmo,malu,mrn,clk,clrn,
                 wwreg,wm2reg,wmo,walu,wrn
    );
	 input [31:0] malu,mmo;
	 input [4:0] mrn;
	 input mwreg,mm2reg;
	 input clk,clrn;
	 output [31:0] walu,wmo;
	 output [4:0] wrn;
	 output wwreg,wm2reg;
	 reg [31:0] walu,wmo;
	 reg [4:0] wrn;
	 reg wwreg,wm2reg;
	 always @(negedge clrn or posedge clk)
	     if(clrn==0)
		      begin
				    wwreg<=0;    wm2reg<=0;    wmo<=0;
					 walu<=0;     wrn<=0;      
					 
			   end
			else
			    begin
				      wwreg<=mwreg;    wm2reg<=mm2reg;    wmo<=mmo;
					   walu<=malu;     wrn<=mrn;      
				 end

endmodule
