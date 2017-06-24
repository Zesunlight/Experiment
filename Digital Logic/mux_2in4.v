module mux_2in4bit(
    input EN_L , S ,
	 input[4:1] D0 , D1 ,
	 output[4:1] Y
    );

    wire w0 , w1 , w2 , w3 , w4 , w5 , w6 , w7 , w8 , w9 ;
	 wire S_L ;
	 
	 not ( S_L , S ) ;
	 
	 nor ( w0 , EN_L , S ) ;
	 nor ( w1 , EN_L , S_L ) ;
	 
	 and ( w2 , D0[1] , w0 ) ;
	 and ( w3 , D1[1] , w1 ) ;	 
	 
	 and ( w4 , D0[2] , w0 ) ;
	 and ( w5 , D1[2] , w1 ) ;	
	 
	 and ( w6 , D0[3] , w0 ) ;
	 and ( w7 , D1[3] , w1 ) ;	

	 and ( w8 , D0[4] , w0 ) ;
	 and ( w9 , D1[4] , w1 ) ;	  

    or  ( Y[1] , w2 , w3 ) ;
    or  ( Y[2] , w4 , w5 ) ; 	 
    or  ( Y[3] , w6 , w7 ) ;
    or  ( Y[4] , w8 , w9 ) ; 	 
	 
endmodule
