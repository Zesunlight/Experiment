initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here		
	   RESET = 0 ;
	end
	
	always begin
	   #5 CLK = ~CLK ;
	end

