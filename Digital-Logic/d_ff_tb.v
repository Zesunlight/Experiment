initial begin
	    CLK = 0 ;
		PR_L = 1 ;
		CLR_L = 1 ;
		D = 0 ;
		
		#4 D = 1 ;
		#2 D = 0 ;		
		#8 D = 0 ;
		#2 D = 1 ;
		#13 CLR_L = 0 ;		
		#10 CLR_L = 1 ;		
		#10 PR_L = 0 ;
		#5  D    = 0 ;		
		#10 PR_L = 1 ;
	end

   always begin
	   #5 CLK = ~CLK ;
   end

