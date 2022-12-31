`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    15:14:23 04/19/13
// Design Name:    
// Module Name:    pipelinedcpu
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module pipelinedcpu(clock,resetn,pc,inst,ealu,malu,walu
    );
	 input clock,resetn;
	 output [31:0] pc,inst,ealu,malu,walu;
	 wire [31:0] bpc,jpc,npc,pc4,ins,dpc4,inst,da,db,dimm,ea,eb,eimm;
	 wire [31:0] epc4,mb,mmo,wmo,wdi;
	 wire [4:0] drn,ern0,ern,mrn,wrn;
	 wire [4:0] daluc,ealuc;
	 wire [1:0] pcsource;
	 wire dwreg,dm2reg,dwmem,daluimm,dshift,djal;
	 wire ewreg,em2reg,ewmem,ealuimm,eshift,ejal;
	 wire mwreg,mm2reg,mwmem;
	 wire wwreg,wm2reg;
	 wire z;
	 pipepc prog_cnt (npc,clock,resetn,pc);//程序计数器PC
	 pipeif if_stage (pcsource,pc,bpc,da,jpc,npc,pc4,ins);//取指IF级
	 pipeir inst_reg (pc4,ins,clock,resetn,dpc4,inst);//IF级与ID级之间的寄存器，即指令寄存器IR
	 pipeid id_stage (dpc4,inst,                        //指令译码ID级
	                  wrn,wdi,wwreg,clock,resetn,
							bpc,jpc,pcsource,dwreg,dm2reg,dwmem,
							daluc,daluimm,da,db,dimm,drn,dshift,djal,z);
	 pipedereg de_reg (dwreg,dm2reg,dwmem,daluc,daluimm,da,db,dimm,//ID级与EXE级之间的寄存器
	                   drn,dshift,djal,dpc4,clock,resetn,
							 ewreg,em2reg,ewmem,ealuc,ealuimm,ea,eb,eimm,
							 ern0,eshift,ejal,epc4);
	 pipeexe exe_stage (ealuc,ealuimm,ea,eb,eimm,eshift,ern0,epc4,//指令执行EXE级
	                    ejal,ern,ealu,z);
	 pipeemreg em_reg (ewreg,em2reg,ewmem,ealu,eb,ern,clock,resetn,//EXE级与MEM级之间的寄存器
	                   mwreg,mm2reg,mwmem,malu,mb,mrn);
	 IP_RAM mem_stage(mwmem,malu,mb,clock,mmo);//存储器访问MEM级
	 pipemwreg mw_reg (mwreg,mm2reg,mmo,malu,mrn,clock,resetn,//MEM级与WB级之间的寄存器
	                   wwreg,wm2reg,wmo,walu,wrn);
	 mux2x32 wb_stage (walu,wmo,wm2reg,wdi);//结果写回WB级，选择结果写回的来源是ALU还是数据存储器
endmodule