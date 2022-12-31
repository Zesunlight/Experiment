module counter_100M(
     input CLK_100MHz ,
	  output CLK_1Hz 
);

    wire CLR_L ;
	wire [27:0] Q ;
	wire [6:0]  RCO ;
	
               // CLK , CLR_L , LD_L , ENP , ENT , D , Q , RCO );
   Vr74x163 u0( CLK_100MHz , CLR_L , 1'b1 , 1'b1 , 1'b1   , 4'b0000 , Q[3:0] ,   RCO[0] );
	Vr74x163 u1( CLK_100MHz , CLR_L , 1'b1 , 1'b1 , RCO[0] , 4'b0000 , Q[7:4] ,   RCO[1] );


	Vr74x163 u6( CLK_100MHz , CLR_L , 1'b1 , 1'b1 , RCO[5] , 4'b0000 , Q[27:24] , RCO[6] );	

   // 100*1000*1000 ( dec ) - 1  =  5F5E0FF (hex)
   nand ( CLR_L , Q[26] , Q[24] ,  RCO[5] , Q[18] ,  Q[16] , Q[15] , Q[14] , Q[13] , RCO[1] , RCO[0] ) ;

   assign CLK_1Hz = Q[26] ;	
endmodule
