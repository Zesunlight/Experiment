// Add stimulus here
	CLR_L = 0 ;
	LD_L = 1'bx ;
	ENT = 1'bx ;
	ENP = 1'bx ;

	#20 ;
	CLR_L = 1 ;
	LD_L = 0;
	ENT = 1'bx ;
	ENP = 1'bx ;
	D = 4'b1111 ;		

	#20 ;
	CLR_L = 1 ;
	LD_L = 1;
	ENT = 0 ;
	ENP = 1'bx ;

	#20 ;
	CLR_L = 1 ;
	LD_L = 1;
	ENT = 1'bx ;
	ENP = 0 ;
	
	#20 ;
	CLR_L = 1 ;
	LD_L = 1;
	ENT = 1 ;
	ENP = 1 ;		
end
  
always begin
  #5 CLK = ~CLK ;
end	
