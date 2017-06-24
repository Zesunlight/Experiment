`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:06 10/26/2012 
// Design Name: 
// Module Name:    shift 
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
module shift(d,sa,right,arith,sh
    );
	 input [31:0] d;
	 input [4:0] sa;
	 input right,arith;
	 output [31:0] sh;
	 wire [31:0] t0,t1,t2,t3,t4,s1,s2,s3,s4;
	 wire a=d[31]&arith;
	 wire [15:0] e={16{a}};
	 parameter z=16'b0;
	 wire [31:0] sdl4,sdr4,sdl3,sdr3,sdl2,sdr2,sdl1,sdr1,sdl0,sdr0;
	 assign sdl4={d[15:0],z};
	 assign sdr4={e,d[31:16]};
	 mux2x32 m_right4(sdl4,sdr4,right,t4);
	 mux2x32 m_shift4(d,t4,sa[4],s4);
	 assign sdl3={s4[23:0],z[7:0]};
	 assign sdr3={e[7:0],s4[31:8]};
	 mux2x32 m_right3(sdl3,sdr3,right,t3);
	 mux2x32 m_shift3(s4,t3,sa[3],s3); 
	 assign sdl2={s3[27:0],z[3:0]};
	 assign sdr2={e[3:0],s3[31:4]};
	 mux2x32 m_right2(sdl2,sdr2,right,t2);
	 mux2x32 m_shift2(s3,t2,sa[2],s2);
    assign sdl1={s2[29:0],z[1:0]};
	 assign sdr1={e[1:0],s2[31:2]};
	 mux2x32 m_right1(sdl1,sdr1,right,t1);
	 mux2x32 m_shift1(s2,t1,sa[1],s1);
	 assign sdl0={s1[30:0],z[0]};
	 assign sdr0={e[0],s1[31:1]};
	 mux2x32 m_right0(sdl0,sdr0,right,t0);
	 mux2x32 m_shift0(s1,t0,sa[0],sh);

endmodule
