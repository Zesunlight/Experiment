module d_ff( CLK , D , PR_L , CLR_L ,
             Q , QN 
    );
   input  CLK , D , PR_L , CLR_L ;
   output Q , QN ;
	
	wire   w1 , w2 , w3 , w4 ;
	
	nand  ( w1 , PR_L , w2 , w4 ) ;
   	nand  ( w2 , CLR_L , w1 , CLK ) ;
	nand  ( w3 , w2 , CLK , w4 ) ;
	nand  ( w4 , w3 , CLR_L , D ) ;
	
	nand  ( Q , PR_L , w2 , QN );
	nand  ( QN , Q , w3 , CLR_L ) ;

endmodule
