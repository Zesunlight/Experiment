module Vr74x194(CLK , CLR_L , LIN , RIN , S1 , S0 , A , B , C , D ,
                QA , QB , QC , QD   
    );
    input  CLK , CLR_L , LIN , RIN , S1 , S0 , A , B , C , D ;
	output QA , QB , QC , QD ;
	
	wire CLK_D ;
	wire CLK_D_L ;
	wire CLR_L_D ;
	wire CLR_L_L ;
	
	wire S1_L , S1_H ;
	wire S0_L , S0_H ;
	wire QAN , QBN , QCN , QDN ;
	
	wire w1 , w2 , w3 , w4 , w5 , w6 , w7 , w8 , w9 , w10 ;
	wire w11 , w12 , w13 , w14 , w15 , w16 , w17 , w18 , w19 , w20 ;
	wire w21 , w22 , w23 , w24 , w25 , w26 , w27 , w28;
	wire w29 , w30 , w31 , w32 , w33 , w34 , w35 , w36;

	not ( CLK_D_L , CLK) ;
	not ( CLK_D , CLK_D_L ) ;
	not ( CLR_L_L , CLR_L ) ;
	not ( CLR_L_D , CLR_L_L ) ;
	
	not ( S1_L , S1 ) ;
	not ( S1_H , S1_L ) ;
	not ( S0_L , S0 ) ;
	not ( S0_H , S0_L ) ;
	
	and ( w1 , LIN , S1_H , S0_L ) ;
	and ( w2 , QD , S1_L , S0_L ) ;
	and ( w3 , D , S1_H , S0_H ) ;
	and ( w16 , QB , S1_H , S0_L ) ;
	and ( w17 , QA , S1_L , S0_L ) ;
	and ( w18 , A , S1_H , S0_H ) ;
	and ( w19 , RIN , S1_L , S0_H ) ;
	or ( w20 , w16 , w17 , w18 , w19 ) ;
	
	nand  ( w21 , w22 , w24 ) ;
    nand  ( w22 , CLR_L , w21 , CLK ) ;
	nand  ( w23 , w22 , CLK_D , w24 ) ;
	nand  ( w24 , w23 , CLR_L_D , w5 ) ;
	nand  ( QD , w22 , QDN );
	nand  ( QDN , QD , w23 , CLR_L_D ) ;
	
	nand  ( w25 , w26 , w28 ) ;
   nand  ( w26 , CLR_L , w25 , CLK ) ;
	nand  ( w27 , w26 , CLK_D , w28 ) ;
	nand  ( w28 , w27 , CLR_L_D , w10 ) ;
	nand  ( QC , w26 , QCN );
	nand  ( QCN , QC , w27 , CLR_L_D ) ;
	
	nand  ( w29 , w30 , w32 ) ;
   nand  ( w30 , CLR_L , w29 , CLK ) ;
	nand  ( w31 , w30 , CLK_D , w32 ) ;
	nand  ( w32 , w31 , CLR_L_D , w15 ) ;
	nand  ( QB , w30 , QBN );
	nand  ( QBN , QB , w31 , CLR_L_D ) ;
	
	nand  ( w33 , w34 , w36 ) ;
    nand  ( w34 , CLR_L , w33 , CLK ) ;
	nand  ( w35 , w34 , CLK_D , w36 ) ;
	nand  ( w36 , w35 , CLR_L_D , w20 ) ;
	nand  ( QA , w34 , QAN );
	nand  ( QAN , QA , w35 , CLR_L_D ) ;
		
endmodule
