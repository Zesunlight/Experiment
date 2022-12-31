initial begin
		// Initialize Inputs
		CLK = 0;
		CLR_L = 0;
		LIN = 0;
		RIN = 0;
		S1 = 0;
		S0 = 0;
		A = 0;
		B = 0;
		C = 0;
		D = 0;

		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
		CLR_L = 1 ;
		S1 = 0 ;
		S0 = 0 ;	

		#100 ;
		S1 = 0 ;
		S0 = 1 ;
		RIN = 1 ;
		
		#100 ;
		S1 = 1 ;
		S0 = 1 ;
		A = 0 ;
		B = 0 ;
		C = 0 ;
		D = 0 ;
		
		#100 ;
		S1 = 1 ;
		S0 = 0 ;
		LIN = 1 ;
		
		#100 ;
		S1 = 1 ;
		S0 = 1 ;
		A = 1 ;
		B = 1 ;
		C = 1 ;
		D = 1 ;
	end
	
	always begin
	   #5 CLK = ~CLK ;
	end
