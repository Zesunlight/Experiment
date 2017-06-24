module LFSR_8( CLK , RESET , X2 , X1 , X0 
    );
	input  CLK , RESET ;
	output X2 , X1 , X0 ;

   wire w1 , w3 , w6 ;
	
   Vr74x194  U1( .CLK(CLK) , 
	             .CLR_L(1'b1) , 
					 .RIN(w6) , 
					 .S1(RESET) , 
					 .S0(1'b1) , 
					 .A(1'b1) , 
					 .B(1'b0) , 
					 .C(1'b0) , 
					 .D(1'b0) ,
                     .QA(X2) , 
					 .QB(X1) , 
					 .QC(X0) ) ;
	
	xor ( w3 , X1 , X0 ) ;
    nor ( w1 , X2 , X1 ) ;
    xor ( w6 , w1 , w3 ) ;	

endmodule
