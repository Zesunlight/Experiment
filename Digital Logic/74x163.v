module Vr74x163( CLK , CLR_L , LD_L , ENP , ENT , D , Q , RCO );
    input  CLK , CLR_L , LD_L , ENP , ENT ;
    input	 [3:0] D ;
	output [3:0] Q ;
	output RCO ;
   
    wire w1 , w2 , w3 , w4 , w5 , w6 , w7 , w8 , w9 , w10 ;
    wire w11 , w12 , w13 , w14 , w15 , w16 , w17 , w18 , w19 , w20 ;
    wire w21 , w22 , w23 , w24 , w25 , w26 ;
	
	wire CK ;
	wire CLR ;
	wire [3:0] QN ;
	wire QAN_L , QBN_L , QCN_L , QDN_L ;
	
	wire CK ;
	wire CLR ;
	wire [3:0] QN ;

	not ( QAN_L , QAN );
	not ( QBN_L , QBN );
	not ( QCN_L , QCN );
	not ( QDN_L , QDN );
	not ( CLR , CLR_L );

	nor ( w1 , CLR , LD_L );
	nor ( w2 , w1 , CLR );
	and ( w3 , w1 , A );
	xor ( w4 , w25 , QAN_L );
	and ( w5 , w2 , w4 );
	or ( w6 , w3 , w5 );

	and ( w7 , B );
	not ( w8 , QAN_L );
	and ( w9 , w8 , w25 );
	xor ( w10 , w9 , QBN_L );
	and ( w11 , w2 , w10 );
	or ( w12 , w7 , w11 );

	and ( w13 , w1 , C );
	nor ( w14 , QAN_L , QBN_L );
	and ( w15 , w14 , w25 );
	xor ( w16 , w15 , QCN_L );
	and ( w17 , w2 , w16 );
	or ( w18 , w13 , w17 );

	and ( w19 , w1 , D );
	nor ( w20 , QAN_L , QBN_L , QCN_L );
	and ( w21 , w20 , w25 );
	xor ( w22 , QDN_L );
	and ( w23 , w2 , w22 );
	or ( w24 , w19 , w23 );

	and ( w25 , ENP , ENT );
	not ( w26 , ENT );
	nor ( RCO , QAN_L , QBN_L , QCN_L , w26 );
	
endmodule
