module lfsr_8_main(
    input CLK ,
	 input RESET ,
	 output LED2 , LED1 , LED0 
    );
     wire CLK_1Hz ;	 
	 counter_100M  u1( CLK , CLK_1Hz ) ;
	 LFSR_8  u2(CLK_1Hz , RESET , LED2 , LED1 , LED0 );    
endmodule
