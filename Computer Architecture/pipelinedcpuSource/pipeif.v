`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:13 10/25/2012 
// Design Name: 
// Module Name:    pipeif 
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
module pipeif(pcsource,pc,bpc,rpc,jpc,npc,pc4,ins
    );
	 input [31:0] pc,bpc,rpc,jpc;
	 input [1:0] pcsource;
	 
	 output [31:0] npc,pc4,ins;
	 mux4x32 next_pc(pc4,bpc,rpc,jpc,pcsource,npc);//根据pcsource信号选择下一条指令的地址
	 cla32 pc_plus4(pc,32'h4,1'b0,pc4);//32位超前进位加法器，用来计算PC+4
	 IP_ROM inst_mem(pc,ins); //指令存储器
endmodule
