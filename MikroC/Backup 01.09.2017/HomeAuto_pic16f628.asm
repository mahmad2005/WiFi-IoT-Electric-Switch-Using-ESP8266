
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;HomeAuto_pic16f628.c,40 :: 		void interrupt(){
;HomeAuto_pic16f628.c,41 :: 		if (INTCON.INTF){          //INTF flag raised, so external interrupt occured
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt0
;HomeAuto_pic16f628.c,42 :: 		ZC = 1;
	BSF        _FlagReg+0, 0
;HomeAuto_pic16f628.c,43 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;HomeAuto_pic16f628.c,45 :: 		INTCON.INTF = 0;
	BCF        INTCON+0, 1
;HomeAuto_pic16f628.c,46 :: 		dimCounter=0;
	CLRF       _DimCounter+0
	CLRF       _DimCounter+1
;HomeAuto_pic16f628.c,47 :: 		CCPR1L =0x00;    //750
	CLRF       CCPR1L+0
;HomeAuto_pic16f628.c,48 :: 		CCPR1H =0x4A;
	MOVLW      74
	MOVWF      CCPR1H+0
;HomeAuto_pic16f628.c,50 :: 		TMR1L =0x00;
	CLRF       TMR1L+0
;HomeAuto_pic16f628.c,51 :: 		TMR1H= 0x00;
	CLRF       TMR1H+0
;HomeAuto_pic16f628.c,55 :: 		}
L_interrupt0:
;HomeAuto_pic16f628.c,56 :: 		if(PIR1.CCP1IF) {
	BTFSS      PIR1+0, 2
	GOTO       L_interrupt1
;HomeAuto_pic16f628.c,58 :: 		PIR1.CCP1IF =0;
	BCF        PIR1+0, 2
;HomeAuto_pic16f628.c,59 :: 		PIR1.TMR1IF =0;
	BCF        PIR1+0, 0
;HomeAuto_pic16f628.c,61 :: 		if(ZC){
	BTFSS      _FlagReg+0, 0
	GOTO       L_interrupt2
;HomeAuto_pic16f628.c,62 :: 		if(isComp1 ==1) {
	MOVLW      0
	XORWF      _isComp1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt49
	MOVLW      1
	XORWF      _isComp1+0, 0
L__interrupt49:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;HomeAuto_pic16f628.c,63 :: 		CompMatch2 = 1;
	MOVLW      1
	MOVWF      _CompMatch2+0
	MOVLW      0
	MOVWF      _CompMatch2+1
;HomeAuto_pic16f628.c,65 :: 		CCPR1L =0xC8;  //300
	MOVLW      200
	MOVWF      CCPR1L+0
;HomeAuto_pic16f628.c,66 :: 		CCPR1H =0xFF;
	MOVLW      255
	MOVWF      CCPR1H+0
;HomeAuto_pic16f628.c,67 :: 		TMR1L=0x00;
	CLRF       TMR1L+0
;HomeAuto_pic16f628.c,68 :: 		TMR1H=0x00;
	CLRF       TMR1H+0
;HomeAuto_pic16f628.c,72 :: 		}
L_interrupt3:
;HomeAuto_pic16f628.c,73 :: 		if(isComp1 ==0){
	MOVLW      0
	XORWF      _isComp1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt50
	MOVLW      0
	XORWF      _isComp1+0, 0
L__interrupt50:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
;HomeAuto_pic16f628.c,74 :: 		CompMatch = 1;
	MOVLW      1
	MOVWF      _CompMatch+0
	MOVLW      0
	MOVWF      _CompMatch+1
;HomeAuto_pic16f628.c,75 :: 		}
L_interrupt4:
;HomeAuto_pic16f628.c,76 :: 		}
L_interrupt2:
;HomeAuto_pic16f628.c,77 :: 		}
L_interrupt1:
;HomeAuto_pic16f628.c,78 :: 		}
L_end_interrupt:
L__interrupt48:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_InitMain:

;HomeAuto_pic16f628.c,81 :: 		void InitMain() {
;HomeAuto_pic16f628.c,82 :: 		PORTA=0;
	CLRF       PORTA+0
;HomeAuto_pic16f628.c,83 :: 		TRISA=0x00;
	CLRF       TRISA+0
;HomeAuto_pic16f628.c,84 :: 		TRISA.RA0=1;
	BSF        TRISA+0, 0
;HomeAuto_pic16f628.c,85 :: 		TRISA.RA1=1;
	BSF        TRISA+0, 1
;HomeAuto_pic16f628.c,86 :: 		TRISA.RA2=0;
	BCF        TRISA+0, 2
;HomeAuto_pic16f628.c,87 :: 		TRISA.RA3=0;
	BCF        TRISA+0, 3
;HomeAuto_pic16f628.c,88 :: 		TRISA.RA4=0;
	BCF        TRISA+0, 4
;HomeAuto_pic16f628.c,89 :: 		TRISA.RA5=0;
	BCF        TRISA+0, 5
;HomeAuto_pic16f628.c,92 :: 		TRISB=0x03;  // rx pin musb be set input. otherwise it will not work
	MOVLW      3
	MOVWF      TRISB+0
;HomeAuto_pic16f628.c,93 :: 		TRISB.RB3=0;
	BCF        TRISB+0, 3
;HomeAuto_pic16f628.c,94 :: 		TRISB.RB4=1;
	BSF        TRISB+0, 4
;HomeAuto_pic16f628.c,95 :: 		TRISB.RB5=1;
	BSF        TRISB+0, 5
;HomeAuto_pic16f628.c,96 :: 		TRISB.RB6=1;
	BSF        TRISB+0, 6
;HomeAuto_pic16f628.c,97 :: 		TRISB.RB7=1;
	BSF        TRISB+0, 7
;HomeAuto_pic16f628.c,98 :: 		PORTB=0;
	CLRF       PORTB+0
;HomeAuto_pic16f628.c,102 :: 		OPTION_REG.INTEDG = 1;      //interrupt on falling edge
	BSF        OPTION_REG+0, 6
;HomeAuto_pic16f628.c,103 :: 		INTCON.INTF = 0;           //clear interrupt flag
	BCF        INTCON+0, 1
;HomeAuto_pic16f628.c,104 :: 		INTCON.INTE = 1;           //enable external interrupt
	BSF        INTCON+0, 4
;HomeAuto_pic16f628.c,105 :: 		INTCON.GIE = 1;            //enable global interrupt
	BSF        INTCON+0, 7
;HomeAuto_pic16f628.c,106 :: 		INTCON.PEIE = 1; // enable periferal interrupt
	BSF        INTCON+0, 6
;HomeAuto_pic16f628.c,111 :: 		TMR1L =0;
	CLRF       TMR1L+0
;HomeAuto_pic16f628.c,112 :: 		TMR1H=0;
	CLRF       TMR1H+0
;HomeAuto_pic16f628.c,114 :: 		T1CON.T1CKPS1 = 0;
	BCF        T1CON+0, 5
;HomeAuto_pic16f628.c,115 :: 		T1CON.T1CKPS0 = 0;
	BCF        T1CON+0, 4
;HomeAuto_pic16f628.c,118 :: 		T1CON.TMR1CS =0; // timer1 Source clock. 0 = internal, 1 = external
	BCF        T1CON+0, 1
;HomeAuto_pic16f628.c,119 :: 		T1CON.TMR1ON=1;    //timer on bit
	BSF        T1CON+0, 0
;HomeAuto_pic16f628.c,121 :: 		PIE1.TMR1IE = 1; // timer overflow enable
	BSF        PIE1+0, 0
;HomeAuto_pic16f628.c,129 :: 		CCP1CON.CCP1M3 = 1;
	BSF        CCP1CON+0, 3
;HomeAuto_pic16f628.c,130 :: 		CCP1CON.CCP1M2 = 0;
	BCF        CCP1CON+0, 2
;HomeAuto_pic16f628.c,131 :: 		CCP1CON.CCP1M1 = 1;
	BSF        CCP1CON+0, 1
;HomeAuto_pic16f628.c,132 :: 		CCP1CON.CCP1M0 = 0;
	BCF        CCP1CON+0, 0
;HomeAuto_pic16f628.c,133 :: 		PIE1.CCP1IE =1;  // CCP1 interrupt enable bit
	BSF        PIE1+0, 2
;HomeAuto_pic16f628.c,136 :: 		CCPR1L =0xFF;
	MOVLW      255
	MOVWF      CCPR1L+0
;HomeAuto_pic16f628.c,137 :: 		CCPR1H =0xFF;
	MOVLW      255
	MOVWF      CCPR1H+0
;HomeAuto_pic16f628.c,142 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;HomeAuto_pic16f628.c,143 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_InitMain5:
	DECFSZ     R13+0, 1
	GOTO       L_InitMain5
	DECFSZ     R12+0, 1
	GOTO       L_InitMain5
	DECFSZ     R11+0, 1
	GOTO       L_InitMain5
	NOP
;HomeAuto_pic16f628.c,145 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr1_HomeAuto_pic16f628+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;HomeAuto_pic16f628.c,146 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;HomeAuto_pic16f628.c,147 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;HomeAuto_pic16f628.c,150 :: 		}
L_end_InitMain:
	RETURN
; end of _InitMain

_main:

;HomeAuto_pic16f628.c,152 :: 		void main() {
;HomeAuto_pic16f628.c,153 :: 		InitMain();
	CALL       _InitMain+0
;HomeAuto_pic16f628.c,154 :: 		while(1) {
L_main6:
;HomeAuto_pic16f628.c,158 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
;HomeAuto_pic16f628.c,159 :: 		UART1_Read_Text(uart_string,"OK",20);     // read the received data,     // eita akta loop er moto kore kaj kore. so jokhon data
	MOVLW      _uart_string+0
	MOVWF      FARG_UART1_Read_Text_Output+0
	MOVLW      ?lstr2_HomeAuto_pic16f628+0
	MOVWF      FARG_UART1_Read_Text_Delimiter+0
	MOVLW      20
	MOVWF      FARG_UART1_Read_Text_Attempts+0
	CALL       _UART1_Read_Text+0
;HomeAuto_pic16f628.c,162 :: 		UART1_Write_Text(uart_string);
	MOVLW      _uart_string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;HomeAuto_pic16f628.c,163 :: 		uart_rd = uart_string[0];
	MOVF       _uart_string+0, 0
	MOVWF      _uart_rd+0
;HomeAuto_pic16f628.c,166 :: 		}
L_main8:
;HomeAuto_pic16f628.c,169 :: 		if (uart_rd == 'A') { shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA; }  //PORTA.RA3 =1;  // bitwise OR kora hoyese..
	MOVF       _uart_rd+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main9
	MOVLW      8
	IORWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
L_main9:
;HomeAuto_pic16f628.c,170 :: 		if (uart_rd == 'B') { shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA3 = 0;  firste bitwise AND kore then bitsie XOR kora hoyuese.
	MOVF       _uart_rd+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main10
	MOVLW      8
	ANDWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       _shadow_PORTA+0, 0
	XORWF      R0+0, 1
	MOVF       _shadow_PORTA+1, 0
	XORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
L_main10:
;HomeAuto_pic16f628.c,171 :: 		if (uart_rd == 'C') { shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;} //PORTA.RA4 = 1
	MOVF       _uart_rd+0, 0
	XORLW      67
	BTFSS      STATUS+0, 2
	GOTO       L_main11
	MOVLW      16
	IORWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
L_main11:
;HomeAuto_pic16f628.c,172 :: 		if (uart_rd == 'D') { shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;} //PORTA.RA4 = 0
	MOVF       _uart_rd+0, 0
	XORLW      68
	BTFSS      STATUS+0, 2
	GOTO       L_main12
	MOVLW      16
	ANDWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       _shadow_PORTA+0, 0
	XORWF      R0+0, 1
	MOVF       _shadow_PORTA+1, 0
	XORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
L_main12:
;HomeAuto_pic16f628.c,175 :: 		if (uart_rd == 'E') { shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;}  //PORTA.RA2 =1
	MOVF       _uart_rd+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVLW      4
	IORWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
L_main13:
;HomeAuto_pic16f628.c,176 :: 		if (uart_rd == 'F') { shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA2 = 0;
	MOVF       _uart_rd+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L_main14
	MOVLW      4
	ANDWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       _shadow_PORTA+0, 0
	XORWF      R0+0, 1
	MOVF       _shadow_PORTA+1, 0
	XORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
L_main14:
;HomeAuto_pic16f628.c,178 :: 		if(uart_string[0] == 'S') {
	MOVF       _uart_string+0, 0
	XORLW      83
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;HomeAuto_pic16f628.c,180 :: 		SPD = (((uart_string[1] - 48)*10)+(uart_string[2]-48));   // ASCII to decimal Convertion
	MOVLW      48
	SUBWF      _uart_string+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      48
	SUBWF      _uart_string+2, 0
	MOVWF      R2+0
	CLRF       R2+1
	BTFSS      STATUS+0, 0
	DECF       R2+1, 1
	MOVF       R2+0, 0
	ADDWF      R0+0, 1
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _SPD+0
	MOVF       R0+1, 0
	MOVWF      _SPD+1
;HomeAuto_pic16f628.c,181 :: 		Dimtime = SPD;
	MOVF       R0+0, 0
	MOVWF      _DimTime+0
	MOVF       R0+1, 0
	MOVWF      _DimTime+1
;HomeAuto_pic16f628.c,190 :: 		}
L_main15:
;HomeAuto_pic16f628.c,192 :: 		uart_rd = 0;
	CLRF       _uart_rd+0
;HomeAuto_pic16f628.c,197 :: 		if (ZC){ //zero crossing occurred
	BTFSS      _FlagReg+0, 0
	GOTO       L_main16
;HomeAuto_pic16f628.c,198 :: 		if(DimTime == 1) {
	MOVLW      0
	XORWF      _DimTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVLW      1
	XORWF      _DimTime+0, 0
L__main53:
	BTFSS      STATUS+0, 2
	GOTO       L_main17
;HomeAuto_pic16f628.c,202 :: 		}
L_main17:
;HomeAuto_pic16f628.c,203 :: 		if(Dimtime == 0) {
	MOVLW      0
	XORWF      _DimTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVLW      0
	XORWF      _DimTime+0, 0
L__main54:
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;HomeAuto_pic16f628.c,206 :: 		}
L_main18:
;HomeAuto_pic16f628.c,207 :: 		if(CompMatch == 1) {
	MOVLW      0
	XORWF      _CompMatch+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVLW      1
	XORWF      _CompMatch+0, 0
L__main55:
	BTFSS      STATUS+0, 2
	GOTO       L_main19
;HomeAuto_pic16f628.c,208 :: 		isComp1 = 1;
	MOVLW      1
	MOVWF      _isComp1+0
	MOVLW      0
	MOVWF      _isComp1+1
;HomeAuto_pic16f628.c,209 :: 		CompMatch = 0;
	CLRF       _CompMatch+0
	CLRF       _CompMatch+1
;HomeAuto_pic16f628.c,211 :: 		shadow_PORTB = shadow_PORTB|8; PORTB = shadow_PORTB;
	MOVLW      8
	IORWF      _shadow_PORTB+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTB+1, 0
	MOVWF      R0+1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTB+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTB+1
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;HomeAuto_pic16f628.c,212 :: 		}
L_main19:
;HomeAuto_pic16f628.c,213 :: 		if(CompMatch2 == 1) {
	MOVLW      0
	XORWF      _CompMatch2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVLW      1
	XORWF      _CompMatch2+0, 0
L__main56:
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;HomeAuto_pic16f628.c,214 :: 		CompMatch2 = 0;
	CLRF       _CompMatch2+0
	CLRF       _CompMatch2+1
;HomeAuto_pic16f628.c,215 :: 		isComp1 = 0;
	CLRF       _isComp1+0
	CLRF       _isComp1+1
;HomeAuto_pic16f628.c,216 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;HomeAuto_pic16f628.c,217 :: 		ZC=0;
	BCF        _FlagReg+0, 0
;HomeAuto_pic16f628.c,219 :: 		shadow_PORTB = ((shadow_PORTB & 8) ^ shadow_PORTB); PORTB = shadow_PORTB;
	MOVLW      8
	ANDWF      _shadow_PORTB+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTB+1, 0
	MOVWF      R0+1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       _shadow_PORTB+0, 0
	XORWF      R0+0, 1
	MOVF       _shadow_PORTB+1, 0
	XORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTB+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTB+1
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;HomeAuto_pic16f628.c,220 :: 		}
L_main20:
;HomeAuto_pic16f628.c,223 :: 		}
L_main16:
;HomeAuto_pic16f628.c,228 :: 		if(PORTA.RA0 == 1) {
	BTFSS      PORTA+0, 0
	GOTO       L_main21
;HomeAuto_pic16f628.c,229 :: 		if(isButtonPressed1 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      0
	XORWF      _isButtonPressed1+0, 0
L__main57:
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;HomeAuto_pic16f628.c,230 :: 		DimTime = DimTime+10;
	MOVLW      10
	ADDWF      _DimTime+0, 1
	BTFSC      STATUS+0, 0
	INCF       _DimTime+1, 1
;HomeAuto_pic16f628.c,231 :: 		isButtonPressed1 =1;
	MOVLW      1
	MOVWF      _isButtonPressed1+0
	MOVLW      0
	MOVWF      _isButtonPressed1+1
;HomeAuto_pic16f628.c,233 :: 		}
L_main22:
;HomeAuto_pic16f628.c,234 :: 		}else {
	GOTO       L_main23
L_main21:
;HomeAuto_pic16f628.c,235 :: 		isButtonPressed1=0;
	CLRF       _isButtonPressed1+0
	CLRF       _isButtonPressed1+1
;HomeAuto_pic16f628.c,237 :: 		}
L_main23:
;HomeAuto_pic16f628.c,239 :: 		if(RA1_bit) {
	BTFSS      RA1_bit+0, BitPos(RA1_bit+0)
	GOTO       L_main24
;HomeAuto_pic16f628.c,240 :: 		if(isButtonPressed2 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVLW      0
	XORWF      _isButtonPressed2+0, 0
L__main58:
	BTFSS      STATUS+0, 2
	GOTO       L_main25
;HomeAuto_pic16f628.c,241 :: 		DimTime = DimTime-10;
	MOVLW      10
	SUBWF      _DimTime+0, 1
	BTFSS      STATUS+0, 0
	DECF       _DimTime+1, 1
;HomeAuto_pic16f628.c,242 :: 		isButtonPressed2 =1;
	MOVLW      1
	MOVWF      _isButtonPressed2+0
	MOVLW      0
	MOVWF      _isButtonPressed2+1
;HomeAuto_pic16f628.c,244 :: 		}
L_main25:
;HomeAuto_pic16f628.c,245 :: 		}else {
	GOTO       L_main26
L_main24:
;HomeAuto_pic16f628.c,246 :: 		isButtonPressed2=0;
	CLRF       _isButtonPressed2+0
	CLRF       _isButtonPressed2+1
;HomeAuto_pic16f628.c,248 :: 		}
L_main26:
;HomeAuto_pic16f628.c,250 :: 		if(RB7_bit) {
	BTFSS      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_main27
;HomeAuto_pic16f628.c,251 :: 		if(isButtonPressed3 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVLW      0
	XORWF      _isButtonPressed3+0, 0
L__main59:
	BTFSS      STATUS+0, 2
	GOTO       L_main28
;HomeAuto_pic16f628.c,252 :: 		isButtonPressed3 =1;
	MOVLW      1
	MOVWF      _isButtonPressed3+0
	MOVLW      0
	MOVWF      _isButtonPressed3+1
;HomeAuto_pic16f628.c,253 :: 		if(isButtonOn ==0) {
	MOVLW      0
	XORWF      _isButtonOn+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      0
	XORWF      _isButtonOn+0, 0
L__main60:
	BTFSS      STATUS+0, 2
	GOTO       L_main29
;HomeAuto_pic16f628.c,254 :: 		isButtonOn = 1;
	MOVLW      1
	MOVWF      _isButtonOn+0
	MOVLW      0
	MOVWF      _isButtonOn+1
;HomeAuto_pic16f628.c,256 :: 		shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA;
	MOVLW      8
	IORWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
;HomeAuto_pic16f628.c,258 :: 		}
	GOTO       L_main30
L_main29:
;HomeAuto_pic16f628.c,260 :: 		isButtonOn = 0;
	CLRF       _isButtonOn+0
	CLRF       _isButtonOn+1
;HomeAuto_pic16f628.c,262 :: 		shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;
	MOVLW      8
	ANDWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       _shadow_PORTA+0, 0
	XORWF      R0+0, 1
	MOVF       _shadow_PORTA+1, 0
	XORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
;HomeAuto_pic16f628.c,263 :: 		}
L_main30:
;HomeAuto_pic16f628.c,265 :: 		}
L_main28:
;HomeAuto_pic16f628.c,266 :: 		}else {
	GOTO       L_main31
L_main27:
;HomeAuto_pic16f628.c,267 :: 		isButtonPressed3=0;
	CLRF       _isButtonPressed3+0
	CLRF       _isButtonPressed3+1
;HomeAuto_pic16f628.c,268 :: 		}
L_main31:
;HomeAuto_pic16f628.c,270 :: 		if(RB6_bit) {
	BTFSS      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_main32
;HomeAuto_pic16f628.c,271 :: 		if(isButtonPressed4 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed4+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVLW      0
	XORWF      _isButtonPressed4+0, 0
L__main61:
	BTFSS      STATUS+0, 2
	GOTO       L_main33
;HomeAuto_pic16f628.c,272 :: 		isButtonPressed4 =1;
	MOVLW      1
	MOVWF      _isButtonPressed4+0
	MOVLW      0
	MOVWF      _isButtonPressed4+1
;HomeAuto_pic16f628.c,273 :: 		if(isButtonOn2 ==0) {
	MOVLW      0
	XORWF      _isButtonOn2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVLW      0
	XORWF      _isButtonOn2+0, 0
L__main62:
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;HomeAuto_pic16f628.c,274 :: 		isButtonOn2 = 1;
	MOVLW      1
	MOVWF      _isButtonOn2+0
	MOVLW      0
	MOVWF      _isButtonOn2+1
;HomeAuto_pic16f628.c,276 :: 		shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;
	MOVLW      16
	IORWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
;HomeAuto_pic16f628.c,277 :: 		}
	GOTO       L_main35
L_main34:
;HomeAuto_pic16f628.c,279 :: 		isButtonOn2 = 0;
	CLRF       _isButtonOn2+0
	CLRF       _isButtonOn2+1
;HomeAuto_pic16f628.c,281 :: 		shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;
	MOVLW      16
	ANDWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       _shadow_PORTA+0, 0
	XORWF      R0+0, 1
	MOVF       _shadow_PORTA+1, 0
	XORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
;HomeAuto_pic16f628.c,282 :: 		}
L_main35:
;HomeAuto_pic16f628.c,284 :: 		}
L_main33:
;HomeAuto_pic16f628.c,285 :: 		}else {
	GOTO       L_main36
L_main32:
;HomeAuto_pic16f628.c,286 :: 		isButtonPressed4=0;
	CLRF       _isButtonPressed4+0
	CLRF       _isButtonPressed4+1
;HomeAuto_pic16f628.c,287 :: 		}
L_main36:
;HomeAuto_pic16f628.c,289 :: 		if(RB5_bit) {
	BTFSS      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_main37
;HomeAuto_pic16f628.c,290 :: 		if(isButtonPressed5 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed5+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVLW      0
	XORWF      _isButtonPressed5+0, 0
L__main63:
	BTFSS      STATUS+0, 2
	GOTO       L_main38
;HomeAuto_pic16f628.c,291 :: 		isButtonPressed5 =1;
	MOVLW      1
	MOVWF      _isButtonPressed5+0
	MOVLW      0
	MOVWF      _isButtonPressed5+1
;HomeAuto_pic16f628.c,292 :: 		if(isButtonOn3 ==0) {
	MOVLW      0
	XORWF      _isButtonOn3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVLW      0
	XORWF      _isButtonOn3+0, 0
L__main64:
	BTFSS      STATUS+0, 2
	GOTO       L_main39
;HomeAuto_pic16f628.c,293 :: 		isButtonOn3 = 1;
	MOVLW      1
	MOVWF      _isButtonOn3+0
	MOVLW      0
	MOVWF      _isButtonOn3+1
;HomeAuto_pic16f628.c,295 :: 		shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;
	MOVLW      4
	IORWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
;HomeAuto_pic16f628.c,296 :: 		}
	GOTO       L_main40
L_main39:
;HomeAuto_pic16f628.c,298 :: 		isButtonOn3 = 0;
	CLRF       _isButtonOn3+0
	CLRF       _isButtonOn3+1
;HomeAuto_pic16f628.c,300 :: 		shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;
	MOVLW      4
	ANDWF      _shadow_PORTA+0, 0
	MOVWF      R0+0
	MOVF       _shadow_PORTA+1, 0
	MOVWF      R0+1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       _shadow_PORTA+0, 0
	XORWF      R0+0, 1
	MOVF       _shadow_PORTA+1, 0
	XORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _shadow_PORTA+0
	MOVF       R0+1, 0
	MOVWF      _shadow_PORTA+1
	MOVF       R0+0, 0
	MOVWF      PORTA+0
;HomeAuto_pic16f628.c,301 :: 		}
L_main40:
;HomeAuto_pic16f628.c,303 :: 		}
L_main38:
;HomeAuto_pic16f628.c,304 :: 		}else {
	GOTO       L_main41
L_main37:
;HomeAuto_pic16f628.c,305 :: 		isButtonPressed5=0;
	CLRF       _isButtonPressed5+0
	CLRF       _isButtonPressed5+1
;HomeAuto_pic16f628.c,306 :: 		}
L_main41:
;HomeAuto_pic16f628.c,308 :: 		if(RB4_bit) {
	BTFSS      RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L_main42
;HomeAuto_pic16f628.c,309 :: 		if(isButtonPressed6 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed6+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVLW      0
	XORWF      _isButtonPressed6+0, 0
L__main65:
	BTFSS      STATUS+0, 2
	GOTO       L_main43
;HomeAuto_pic16f628.c,310 :: 		isButtonPressed6 =1;
	MOVLW      1
	MOVWF      _isButtonPressed6+0
	MOVLW      0
	MOVWF      _isButtonPressed6+1
;HomeAuto_pic16f628.c,311 :: 		if(isButtonOn4 ==0) {
	MOVLW      0
	XORWF      _isButtonOn4+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVLW      0
	XORWF      _isButtonOn4+0, 0
L__main66:
	BTFSS      STATUS+0, 2
	GOTO       L_main44
;HomeAuto_pic16f628.c,312 :: 		isButtonOn4 = 1;
	MOVLW      1
	MOVWF      _isButtonOn4+0
	MOVLW      0
	MOVWF      _isButtonOn4+1
;HomeAuto_pic16f628.c,314 :: 		}
	GOTO       L_main45
L_main44:
;HomeAuto_pic16f628.c,316 :: 		isButtonOn4 = 0;
	CLRF       _isButtonOn4+0
	CLRF       _isButtonOn4+1
;HomeAuto_pic16f628.c,318 :: 		}
L_main45:
;HomeAuto_pic16f628.c,320 :: 		}
L_main43:
;HomeAuto_pic16f628.c,321 :: 		}else {
	GOTO       L_main46
L_main42:
;HomeAuto_pic16f628.c,322 :: 		isButtonPressed6=0;
	CLRF       _isButtonPressed6+0
	CLRF       _isButtonPressed6+1
;HomeAuto_pic16f628.c,323 :: 		}
L_main46:
;HomeAuto_pic16f628.c,325 :: 		}
	GOTO       L_main6
;HomeAuto_pic16f628.c,326 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
