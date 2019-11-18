
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;HomeAuto_pic16f628.c,38 :: 		void interrupt(){
;HomeAuto_pic16f628.c,39 :: 		if (INTCON.INTF){          //INTF flag raised, so external interrupt occured
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt0
;HomeAuto_pic16f628.c,40 :: 		ZC = 1;
	BSF        _FlagReg+0, 0
;HomeAuto_pic16f628.c,41 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;HomeAuto_pic16f628.c,43 :: 		INTCON.INTF = 0;
	BCF        INTCON+0, 1
;HomeAuto_pic16f628.c,44 :: 		dimCounter=0;
	CLRF       _DimCounter+0
	CLRF       _DimCounter+1
;HomeAuto_pic16f628.c,45 :: 		}
L_interrupt0:
;HomeAuto_pic16f628.c,46 :: 		if(PIR1.CCP1IF) {
	BTFSS      PIR1+0, 2
	GOTO       L_interrupt1
;HomeAuto_pic16f628.c,48 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;HomeAuto_pic16f628.c,49 :: 		PIR1.CCP1IF =0;
	BCF        PIR1+0, 2
;HomeAuto_pic16f628.c,50 :: 		PIR1.TMR1IF =0;
	BCF        PIR1+0, 0
;HomeAuto_pic16f628.c,51 :: 		CompMatch = 1;
	MOVLW      1
	MOVWF      _CompMatch+0
	MOVLW      0
	MOVWF      _CompMatch+1
;HomeAuto_pic16f628.c,52 :: 		TMR1L=0;
	CLRF       TMR1L+0
;HomeAuto_pic16f628.c,53 :: 		TMR1H=0;
	CLRF       TMR1H+0
;HomeAuto_pic16f628.c,54 :: 		}
L_interrupt1:
;HomeAuto_pic16f628.c,55 :: 		}
L_end_interrupt:
L__interrupt47:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_InitMain:

;HomeAuto_pic16f628.c,58 :: 		void InitMain() {
;HomeAuto_pic16f628.c,59 :: 		PORTA=0;
	CLRF       PORTA+0
;HomeAuto_pic16f628.c,60 :: 		TRISA=0x00;
	CLRF       TRISA+0
;HomeAuto_pic16f628.c,61 :: 		TRISA.RA0=1;
	BSF        TRISA+0, 0
;HomeAuto_pic16f628.c,62 :: 		TRISA.RA1=1;
	BSF        TRISA+0, 1
;HomeAuto_pic16f628.c,63 :: 		TRISA.RA2=0;
	BCF        TRISA+0, 2
;HomeAuto_pic16f628.c,64 :: 		TRISA.RA3=0;
	BCF        TRISA+0, 3
;HomeAuto_pic16f628.c,65 :: 		TRISA.RA4=0;
	BCF        TRISA+0, 4
;HomeAuto_pic16f628.c,66 :: 		TRISA.RA5=0;
	BCF        TRISA+0, 5
;HomeAuto_pic16f628.c,69 :: 		TRISB=0x03;  // rx pin musb be set input. otherwise it will not work
	MOVLW      3
	MOVWF      TRISB+0
;HomeAuto_pic16f628.c,70 :: 		TRISB.RB3=0;
	BCF        TRISB+0, 3
;HomeAuto_pic16f628.c,71 :: 		TRISB.RB4=1;
	BSF        TRISB+0, 4
;HomeAuto_pic16f628.c,72 :: 		TRISB.RB5=1;
	BSF        TRISB+0, 5
;HomeAuto_pic16f628.c,73 :: 		TRISB.RB6=1;
	BSF        TRISB+0, 6
;HomeAuto_pic16f628.c,74 :: 		TRISB.RB7=1;
	BSF        TRISB+0, 7
;HomeAuto_pic16f628.c,75 :: 		PORTB=0;
	CLRF       PORTB+0
;HomeAuto_pic16f628.c,79 :: 		OPTION_REG.INTEDG = 1;      //interrupt on falling edge
	BSF        OPTION_REG+0, 6
;HomeAuto_pic16f628.c,80 :: 		INTCON.INTF = 0;           //clear interrupt flag
	BCF        INTCON+0, 1
;HomeAuto_pic16f628.c,81 :: 		INTCON.INTE = 1;           //enable external interrupt
	BSF        INTCON+0, 4
;HomeAuto_pic16f628.c,82 :: 		INTCON.GIE = 1;            //enable global interrupt
	BSF        INTCON+0, 7
;HomeAuto_pic16f628.c,83 :: 		INTCON.PEIE = 1; // enable periferal interrupt
	BSF        INTCON+0, 6
;HomeAuto_pic16f628.c,88 :: 		TMR1L =0;
	CLRF       TMR1L+0
;HomeAuto_pic16f628.c,89 :: 		TMR1H=0;
	CLRF       TMR1H+0
;HomeAuto_pic16f628.c,91 :: 		T1CON.T1CKPS1 = 0;
	BCF        T1CON+0, 5
;HomeAuto_pic16f628.c,92 :: 		T1CON.T1CKPS0 = 0;
	BCF        T1CON+0, 4
;HomeAuto_pic16f628.c,95 :: 		T1CON.TMR1CS =0; // timer1 Source clock. 0 = internal, 1 = external
	BCF        T1CON+0, 1
;HomeAuto_pic16f628.c,96 :: 		T1CON.TMR1ON=1;    //timer on bit
	BSF        T1CON+0, 0
;HomeAuto_pic16f628.c,98 :: 		PIE1.TMR1IE = 1; // timer overflow enable
	BSF        PIE1+0, 0
;HomeAuto_pic16f628.c,106 :: 		CCP1CON.CCP1M3 = 1;
	BSF        CCP1CON+0, 3
;HomeAuto_pic16f628.c,107 :: 		CCP1CON.CCP1M2 = 0;
	BCF        CCP1CON+0, 2
;HomeAuto_pic16f628.c,108 :: 		CCP1CON.CCP1M1 = 1;
	BSF        CCP1CON+0, 1
;HomeAuto_pic16f628.c,109 :: 		CCP1CON.CCP1M0 = 0;
	BCF        CCP1CON+0, 0
;HomeAuto_pic16f628.c,110 :: 		PIE1.CCP1IE =1;  // CCP1 interrupt enable bit
	BSF        PIE1+0, 2
;HomeAuto_pic16f628.c,113 :: 		CCPR1L =0x4B;
	MOVLW      75
	MOVWF      CCPR1L+0
;HomeAuto_pic16f628.c,114 :: 		CCPR1H =0x00;
	CLRF       CCPR1H+0
;HomeAuto_pic16f628.c,119 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;HomeAuto_pic16f628.c,120 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_InitMain2:
	DECFSZ     R13+0, 1
	GOTO       L_InitMain2
	DECFSZ     R12+0, 1
	GOTO       L_InitMain2
	DECFSZ     R11+0, 1
	GOTO       L_InitMain2
	NOP
;HomeAuto_pic16f628.c,122 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr1_HomeAuto_pic16f628+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;HomeAuto_pic16f628.c,123 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;HomeAuto_pic16f628.c,124 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;HomeAuto_pic16f628.c,127 :: 		}
L_end_InitMain:
	RETURN
; end of _InitMain

_main:

;HomeAuto_pic16f628.c,129 :: 		void main() {
;HomeAuto_pic16f628.c,130 :: 		InitMain();
	CALL       _InitMain+0
;HomeAuto_pic16f628.c,131 :: 		while(1) {
L_main3:
;HomeAuto_pic16f628.c,135 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;HomeAuto_pic16f628.c,136 :: 		UART1_Read_Text(uart_string,"OK",20);     // read the received data,     // eita akta loop er moto kore kaj kore. so jokhon data
	MOVLW      _uart_string+0
	MOVWF      FARG_UART1_Read_Text_Output+0
	MOVLW      ?lstr2_HomeAuto_pic16f628+0
	MOVWF      FARG_UART1_Read_Text_Delimiter+0
	MOVLW      20
	MOVWF      FARG_UART1_Read_Text_Attempts+0
	CALL       _UART1_Read_Text+0
;HomeAuto_pic16f628.c,139 :: 		UART1_Write_Text(uart_string);
	MOVLW      _uart_string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;HomeAuto_pic16f628.c,140 :: 		uart_rd = uart_string[0];
	MOVF       _uart_string+0, 0
	MOVWF      _uart_rd+0
;HomeAuto_pic16f628.c,143 :: 		}
L_main5:
;HomeAuto_pic16f628.c,146 :: 		if (uart_rd == 'A') { shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA; }  //PORTA.RA3 =1;  // bitwise OR kora hoyese..
	MOVF       _uart_rd+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main6
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
L_main6:
;HomeAuto_pic16f628.c,147 :: 		if (uart_rd == 'B') { shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA3 = 0;  firste bitwise AND kore then bitsie XOR kora hoyuese.
	MOVF       _uart_rd+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main7
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
L_main7:
;HomeAuto_pic16f628.c,148 :: 		if (uart_rd == 'C') { shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;} //PORTA.RA4 = 1
	MOVF       _uart_rd+0, 0
	XORLW      67
	BTFSS      STATUS+0, 2
	GOTO       L_main8
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
L_main8:
;HomeAuto_pic16f628.c,149 :: 		if (uart_rd == 'D') { shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;} //PORTA.RA4 = 0
	MOVF       _uart_rd+0, 0
	XORLW      68
	BTFSS      STATUS+0, 2
	GOTO       L_main9
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
L_main9:
;HomeAuto_pic16f628.c,152 :: 		if (uart_rd == 'E') { shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;}  //PORTA.RA2 =1
	MOVF       _uart_rd+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main10
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
L_main10:
;HomeAuto_pic16f628.c,153 :: 		if (uart_rd == 'F') { shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA2 = 0;
	MOVF       _uart_rd+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L_main11
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
L_main11:
;HomeAuto_pic16f628.c,155 :: 		if(uart_string[0] == 'S') {
	MOVF       _uart_string+0, 0
	XORLW      83
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;HomeAuto_pic16f628.c,157 :: 		SPD = (((uart_string[1] - 48)*100)+(((uart_string[2])-48)*10)+(uart_string[3]-48) );   // ASCII to decimal Convertion
	MOVLW      48
	SUBWF      _uart_string+1, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      48
	SUBWF      _uart_string+2, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	ADDWF      FLOC__main+0, 0
	MOVWF      R2+0
	MOVF       FLOC__main+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVLW      48
	SUBWF      _uart_string+3, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
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
;HomeAuto_pic16f628.c,158 :: 		Dimtime = SPD;
	MOVF       R0+0, 0
	MOVWF      _DimTime+0
	MOVF       R0+1, 0
	MOVWF      _DimTime+1
;HomeAuto_pic16f628.c,159 :: 		uart_string[0]="";
	MOVLW      ?lstr_3_HomeAuto_pic16f628+0
	MOVWF      _uart_string+0
;HomeAuto_pic16f628.c,168 :: 		}
L_main12:
;HomeAuto_pic16f628.c,170 :: 		uart_rd = 0;
	CLRF       _uart_rd+0
;HomeAuto_pic16f628.c,173 :: 		if(CompMatch == 1) {
	MOVLW      0
	XORWF      _CompMatch+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVLW      1
	XORWF      _CompMatch+0, 0
L__main50:
	BTFSS      STATUS+0, 2
	GOTO       L_main13
;HomeAuto_pic16f628.c,174 :: 		CompMatch=0;
	CLRF       _CompMatch+0
	CLRF       _CompMatch+1
;HomeAuto_pic16f628.c,175 :: 		if (ZC){ //zero crossing occurred
	BTFSS      _FlagReg+0, 0
	GOTO       L_main14
;HomeAuto_pic16f628.c,176 :: 		if(DimTime == 1) {
	MOVLW      0
	XORWF      _DimTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      1
	XORWF      _DimTime+0, 0
L__main51:
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;HomeAuto_pic16f628.c,178 :: 		shadow_PORTB = shadow_PORTB|8; PORTB = shadow_PORTB; //RB3 on
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
;HomeAuto_pic16f628.c,180 :: 		}
L_main15:
;HomeAuto_pic16f628.c,181 :: 		if(Dimtime == 0) {
	MOVLW      0
	XORWF      _DimTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVLW      0
	XORWF      _DimTime+0, 0
L__main52:
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;HomeAuto_pic16f628.c,183 :: 		shadow_PORTB = ((shadow_PORTB & 8) ^ shadow_PORTB); PORTB = shadow_PORTB;
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
;HomeAuto_pic16f628.c,184 :: 		} else {
	GOTO       L_main17
L_main16:
;HomeAuto_pic16f628.c,185 :: 		if(i>=DimTime) {
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _DimTime+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main53
	MOVF       _DimTime+0, 0
	SUBWF      _i+0, 0
L__main53:
	BTFSS      STATUS+0, 0
	GOTO       L_main18
;HomeAuto_pic16f628.c,187 :: 		shadow_PORTB = shadow_PORTB|8; PORTB = shadow_PORTB;
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
;HomeAuto_pic16f628.c,188 :: 		}
L_main18:
;HomeAuto_pic16f628.c,189 :: 		if(i>(DimTime+4)) {
	MOVLW      4
	ADDWF      _DimTime+0, 0
	MOVWF      R1+0
	MOVF       _DimTime+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main54
	MOVF       _i+0, 0
	SUBWF      R1+0, 0
L__main54:
	BTFSC      STATUS+0, 0
	GOTO       L_main19
;HomeAuto_pic16f628.c,190 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;HomeAuto_pic16f628.c,191 :: 		ZC=0;
	BCF        _FlagReg+0, 0
;HomeAuto_pic16f628.c,193 :: 		shadow_PORTB = ((shadow_PORTB & 8) ^ shadow_PORTB); PORTB = shadow_PORTB;
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
;HomeAuto_pic16f628.c,194 :: 		}
L_main19:
;HomeAuto_pic16f628.c,198 :: 		}
L_main17:
;HomeAuto_pic16f628.c,199 :: 		}
L_main14:
;HomeAuto_pic16f628.c,200 :: 		}
L_main13:
;HomeAuto_pic16f628.c,204 :: 		if(PORTA.RA0 == 1) {
	BTFSS      PORTA+0, 0
	GOTO       L_main20
;HomeAuto_pic16f628.c,205 :: 		if(isButtonPressed1 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main55
	MOVLW      0
	XORWF      _isButtonPressed1+0, 0
L__main55:
	BTFSS      STATUS+0, 2
	GOTO       L_main21
;HomeAuto_pic16f628.c,206 :: 		DimTime = DimTime+10;
	MOVLW      10
	ADDWF      _DimTime+0, 1
	BTFSC      STATUS+0, 0
	INCF       _DimTime+1, 1
;HomeAuto_pic16f628.c,207 :: 		isButtonPressed1 =1;
	MOVLW      1
	MOVWF      _isButtonPressed1+0
	MOVLW      0
	MOVWF      _isButtonPressed1+1
;HomeAuto_pic16f628.c,209 :: 		}
L_main21:
;HomeAuto_pic16f628.c,210 :: 		}else {
	GOTO       L_main22
L_main20:
;HomeAuto_pic16f628.c,211 :: 		isButtonPressed1=0;
	CLRF       _isButtonPressed1+0
	CLRF       _isButtonPressed1+1
;HomeAuto_pic16f628.c,213 :: 		}
L_main22:
;HomeAuto_pic16f628.c,215 :: 		if(RA1_bit) {
	BTFSS      RA1_bit+0, BitPos(RA1_bit+0)
	GOTO       L_main23
;HomeAuto_pic16f628.c,216 :: 		if(isButtonPressed2 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main56
	MOVLW      0
	XORWF      _isButtonPressed2+0, 0
L__main56:
	BTFSS      STATUS+0, 2
	GOTO       L_main24
;HomeAuto_pic16f628.c,217 :: 		DimTime = DimTime-10;
	MOVLW      10
	SUBWF      _DimTime+0, 1
	BTFSS      STATUS+0, 0
	DECF       _DimTime+1, 1
;HomeAuto_pic16f628.c,218 :: 		isButtonPressed2 =1;
	MOVLW      1
	MOVWF      _isButtonPressed2+0
	MOVLW      0
	MOVWF      _isButtonPressed2+1
;HomeAuto_pic16f628.c,220 :: 		}
L_main24:
;HomeAuto_pic16f628.c,221 :: 		}else {
	GOTO       L_main25
L_main23:
;HomeAuto_pic16f628.c,222 :: 		isButtonPressed2=0;
	CLRF       _isButtonPressed2+0
	CLRF       _isButtonPressed2+1
;HomeAuto_pic16f628.c,224 :: 		}
L_main25:
;HomeAuto_pic16f628.c,226 :: 		if(RB7_bit) {
	BTFSS      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_main26
;HomeAuto_pic16f628.c,227 :: 		if(isButtonPressed3 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main57
	MOVLW      0
	XORWF      _isButtonPressed3+0, 0
L__main57:
	BTFSS      STATUS+0, 2
	GOTO       L_main27
;HomeAuto_pic16f628.c,228 :: 		isButtonPressed3 =1;
	MOVLW      1
	MOVWF      _isButtonPressed3+0
	MOVLW      0
	MOVWF      _isButtonPressed3+1
;HomeAuto_pic16f628.c,229 :: 		if(isButtonOn ==0) {
	MOVLW      0
	XORWF      _isButtonOn+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main58
	MOVLW      0
	XORWF      _isButtonOn+0, 0
L__main58:
	BTFSS      STATUS+0, 2
	GOTO       L_main28
;HomeAuto_pic16f628.c,230 :: 		isButtonOn = 1;
	MOVLW      1
	MOVWF      _isButtonOn+0
	MOVLW      0
	MOVWF      _isButtonOn+1
;HomeAuto_pic16f628.c,232 :: 		shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA;
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
;HomeAuto_pic16f628.c,234 :: 		}
	GOTO       L_main29
L_main28:
;HomeAuto_pic16f628.c,236 :: 		isButtonOn = 0;
	CLRF       _isButtonOn+0
	CLRF       _isButtonOn+1
;HomeAuto_pic16f628.c,238 :: 		shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;
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
;HomeAuto_pic16f628.c,239 :: 		}
L_main29:
;HomeAuto_pic16f628.c,241 :: 		}
L_main27:
;HomeAuto_pic16f628.c,242 :: 		}else {
	GOTO       L_main30
L_main26:
;HomeAuto_pic16f628.c,243 :: 		isButtonPressed3=0;
	CLRF       _isButtonPressed3+0
	CLRF       _isButtonPressed3+1
;HomeAuto_pic16f628.c,244 :: 		}
L_main30:
;HomeAuto_pic16f628.c,246 :: 		if(RB6_bit) {
	BTFSS      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_main31
;HomeAuto_pic16f628.c,247 :: 		if(isButtonPressed4 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed4+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVLW      0
	XORWF      _isButtonPressed4+0, 0
L__main59:
	BTFSS      STATUS+0, 2
	GOTO       L_main32
;HomeAuto_pic16f628.c,248 :: 		isButtonPressed4 =1;
	MOVLW      1
	MOVWF      _isButtonPressed4+0
	MOVLW      0
	MOVWF      _isButtonPressed4+1
;HomeAuto_pic16f628.c,249 :: 		if(isButtonOn2 ==0) {
	MOVLW      0
	XORWF      _isButtonOn2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      0
	XORWF      _isButtonOn2+0, 0
L__main60:
	BTFSS      STATUS+0, 2
	GOTO       L_main33
;HomeAuto_pic16f628.c,250 :: 		isButtonOn2 = 1;
	MOVLW      1
	MOVWF      _isButtonOn2+0
	MOVLW      0
	MOVWF      _isButtonOn2+1
;HomeAuto_pic16f628.c,252 :: 		shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;
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
;HomeAuto_pic16f628.c,253 :: 		}
	GOTO       L_main34
L_main33:
;HomeAuto_pic16f628.c,255 :: 		isButtonOn2 = 0;
	CLRF       _isButtonOn2+0
	CLRF       _isButtonOn2+1
;HomeAuto_pic16f628.c,257 :: 		shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;
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
;HomeAuto_pic16f628.c,258 :: 		}
L_main34:
;HomeAuto_pic16f628.c,260 :: 		}
L_main32:
;HomeAuto_pic16f628.c,261 :: 		}else {
	GOTO       L_main35
L_main31:
;HomeAuto_pic16f628.c,262 :: 		isButtonPressed4=0;
	CLRF       _isButtonPressed4+0
	CLRF       _isButtonPressed4+1
;HomeAuto_pic16f628.c,263 :: 		}
L_main35:
;HomeAuto_pic16f628.c,265 :: 		if(RB5_bit) {
	BTFSS      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_main36
;HomeAuto_pic16f628.c,266 :: 		if(isButtonPressed5 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed5+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVLW      0
	XORWF      _isButtonPressed5+0, 0
L__main61:
	BTFSS      STATUS+0, 2
	GOTO       L_main37
;HomeAuto_pic16f628.c,267 :: 		isButtonPressed5 =1;
	MOVLW      1
	MOVWF      _isButtonPressed5+0
	MOVLW      0
	MOVWF      _isButtonPressed5+1
;HomeAuto_pic16f628.c,268 :: 		if(isButtonOn3 ==0) {
	MOVLW      0
	XORWF      _isButtonOn3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVLW      0
	XORWF      _isButtonOn3+0, 0
L__main62:
	BTFSS      STATUS+0, 2
	GOTO       L_main38
;HomeAuto_pic16f628.c,269 :: 		isButtonOn3 = 1;
	MOVLW      1
	MOVWF      _isButtonOn3+0
	MOVLW      0
	MOVWF      _isButtonOn3+1
;HomeAuto_pic16f628.c,271 :: 		shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;
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
;HomeAuto_pic16f628.c,272 :: 		}
	GOTO       L_main39
L_main38:
;HomeAuto_pic16f628.c,274 :: 		isButtonOn3 = 0;
	CLRF       _isButtonOn3+0
	CLRF       _isButtonOn3+1
;HomeAuto_pic16f628.c,276 :: 		shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;
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
;HomeAuto_pic16f628.c,277 :: 		}
L_main39:
;HomeAuto_pic16f628.c,279 :: 		}
L_main37:
;HomeAuto_pic16f628.c,280 :: 		}else {
	GOTO       L_main40
L_main36:
;HomeAuto_pic16f628.c,281 :: 		isButtonPressed5=0;
	CLRF       _isButtonPressed5+0
	CLRF       _isButtonPressed5+1
;HomeAuto_pic16f628.c,282 :: 		}
L_main40:
;HomeAuto_pic16f628.c,284 :: 		if(RB4_bit) {
	BTFSS      RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L_main41
;HomeAuto_pic16f628.c,285 :: 		if(isButtonPressed6 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed6+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVLW      0
	XORWF      _isButtonPressed6+0, 0
L__main63:
	BTFSS      STATUS+0, 2
	GOTO       L_main42
;HomeAuto_pic16f628.c,286 :: 		isButtonPressed6 =1;
	MOVLW      1
	MOVWF      _isButtonPressed6+0
	MOVLW      0
	MOVWF      _isButtonPressed6+1
;HomeAuto_pic16f628.c,287 :: 		if(isButtonOn4 ==0) {
	MOVLW      0
	XORWF      _isButtonOn4+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVLW      0
	XORWF      _isButtonOn4+0, 0
L__main64:
	BTFSS      STATUS+0, 2
	GOTO       L_main43
;HomeAuto_pic16f628.c,288 :: 		isButtonOn4 = 1;
	MOVLW      1
	MOVWF      _isButtonOn4+0
	MOVLW      0
	MOVWF      _isButtonOn4+1
;HomeAuto_pic16f628.c,290 :: 		Dimtime = 0;
	CLRF       _DimTime+0
	CLRF       _DimTime+1
;HomeAuto_pic16f628.c,291 :: 		}
	GOTO       L_main44
L_main43:
;HomeAuto_pic16f628.c,293 :: 		isButtonOn4 = 0;
	CLRF       _isButtonOn4+0
	CLRF       _isButtonOn4+1
;HomeAuto_pic16f628.c,295 :: 		}
L_main44:
;HomeAuto_pic16f628.c,297 :: 		}
L_main42:
;HomeAuto_pic16f628.c,298 :: 		}else {
	GOTO       L_main45
L_main41:
;HomeAuto_pic16f628.c,299 :: 		isButtonPressed6=0;
	CLRF       _isButtonPressed6+0
	CLRF       _isButtonPressed6+1
;HomeAuto_pic16f628.c,300 :: 		}
L_main45:
;HomeAuto_pic16f628.c,302 :: 		}
	GOTO       L_main3
;HomeAuto_pic16f628.c,303 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
