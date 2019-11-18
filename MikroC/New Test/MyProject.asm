
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,35 :: 		void interrupt(){
;MyProject.c,36 :: 		if (INTCON.INTF){          //INTF flag raised, so external interrupt occured
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt0
;MyProject.c,37 :: 		ZC = 1;
	BSF        _FlagReg+0, 0
;MyProject.c,38 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;MyProject.c,40 :: 		INTCON.INTF = 0;
	BCF        INTCON+0, 1
;MyProject.c,41 :: 		dimCounter=0;
	CLRF       _DimCounter+0
	CLRF       _DimCounter+1
;MyProject.c,42 :: 		}
L_interrupt0:
;MyProject.c,43 :: 		if(PIR1.CCP1IF) {
	BTFSS      PIR1+0, 2
	GOTO       L_interrupt1
;MyProject.c,45 :: 		PIR1.CCP1IF =0;
	BCF        PIR1+0, 2
;MyProject.c,46 :: 		PIR1.TMR1IF =0;
	BCF        PIR1+0, 0
;MyProject.c,47 :: 		CompMatch = 1;
	MOVLW      1
	MOVWF      _CompMatch+0
	MOVLW      0
	MOVWF      _CompMatch+1
;MyProject.c,48 :: 		TMR1L=0;
	CLRF       TMR1L+0
;MyProject.c,49 :: 		TMR1H=0;
	CLRF       TMR1H+0
;MyProject.c,50 :: 		}
L_interrupt1:
;MyProject.c,51 :: 		}
L_end_interrupt:
L__interrupt56:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_InitMain:

;MyProject.c,54 :: 		void InitMain() {
;MyProject.c,55 :: 		PORTA=0;
	CLRF       PORTA+0
;MyProject.c,56 :: 		TRISA=0x00;
	CLRF       TRISA+0
;MyProject.c,57 :: 		TRISA.RA0=1;
	BSF        TRISA+0, 0
;MyProject.c,58 :: 		TRISA.RA1=1;
	BSF        TRISA+0, 1
;MyProject.c,59 :: 		TRISA.RA2=0;
	BCF        TRISA+0, 2
;MyProject.c,60 :: 		TRISA.RA3=0;
	BCF        TRISA+0, 3
;MyProject.c,61 :: 		TRISA.RA4=0;
	BCF        TRISA+0, 4
;MyProject.c,62 :: 		TRISA.RA5=0;
	BCF        TRISA+0, 5
;MyProject.c,65 :: 		TRISB=0x03;  // rx pin musb be set input. otherwise it will not work
	MOVLW      3
	MOVWF      TRISB+0
;MyProject.c,66 :: 		TRISB.RB3=0;
	BCF        TRISB+0, 3
;MyProject.c,67 :: 		TRISB.RB4=1;
	BSF        TRISB+0, 4
;MyProject.c,68 :: 		TRISB.RB5=1;
	BSF        TRISB+0, 5
;MyProject.c,69 :: 		TRISB.RB6=1;
	BSF        TRISB+0, 6
;MyProject.c,70 :: 		TRISB.RB7=1;
	BSF        TRISB+0, 7
;MyProject.c,71 :: 		PORTB=0;
	CLRF       PORTB+0
;MyProject.c,75 :: 		OPTION_REG.INTEDG = 1;      //interrupt on falling edge
	BSF        OPTION_REG+0, 6
;MyProject.c,76 :: 		INTCON.INTF = 0;           //clear interrupt flag
	BCF        INTCON+0, 1
;MyProject.c,77 :: 		INTCON.INTE = 1;           //enable external interrupt
	BSF        INTCON+0, 4
;MyProject.c,78 :: 		INTCON.GIE = 1;            //enable global interrupt
	BSF        INTCON+0, 7
;MyProject.c,79 :: 		INTCON.PEIE = 1; // enable periferal interrupt
	BSF        INTCON+0, 6
;MyProject.c,84 :: 		TMR1L =0;
	CLRF       TMR1L+0
;MyProject.c,85 :: 		TMR1H=0;
	CLRF       TMR1H+0
;MyProject.c,87 :: 		T1CON.T1CKPS1 = 0;
	BCF        T1CON+0, 5
;MyProject.c,88 :: 		T1CON.T1CKPS0 = 0;
	BCF        T1CON+0, 4
;MyProject.c,91 :: 		T1CON.TMR1CS =0; // timer1 Source clock. 0 = internal, 1 = external
	BCF        T1CON+0, 1
;MyProject.c,92 :: 		T1CON.TMR1ON=1;    //timer on bit
	BSF        T1CON+0, 0
;MyProject.c,94 :: 		PIE1.TMR1IE = 1; // timer overflow enable
	BSF        PIE1+0, 0
;MyProject.c,102 :: 		CCP1CON.CCP1M3 = 1;
	BSF        CCP1CON+0, 3
;MyProject.c,103 :: 		CCP1CON.CCP1M2 = 0;
	BCF        CCP1CON+0, 2
;MyProject.c,104 :: 		CCP1CON.CCP1M1 = 1;
	BSF        CCP1CON+0, 1
;MyProject.c,105 :: 		CCP1CON.CCP1M0 = 0;
	BCF        CCP1CON+0, 0
;MyProject.c,106 :: 		PIE1.CCP1IE =1;  // CCP1 interrupt enable bit
	BSF        PIE1+0, 2
;MyProject.c,109 :: 		CCPR1L =0x4B;
	MOVLW      75
	MOVWF      CCPR1L+0
;MyProject.c,110 :: 		CCPR1H =0x00;
	CLRF       CCPR1H+0
;MyProject.c,115 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,116 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
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
;MyProject.c,118 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,119 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,120 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,123 :: 		}
L_end_InitMain:
	RETURN
; end of _InitMain

_main:

;MyProject.c,125 :: 		void main() {
;MyProject.c,126 :: 		InitMain();
	CALL       _InitMain+0
;MyProject.c,127 :: 		while(1) {
L_main3:
;MyProject.c,131 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;MyProject.c,134 :: 		uart_string[k] = UART1_Read();
	MOVF       _k+0, 0
	ADDLW      _uart_string+0
	MOVWF      FLOC__main+0
	CALL       _UART1_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,135 :: 		UART1_Write(uart_string[k]);
	MOVF       _k+0, 0
	ADDLW      _uart_string+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;MyProject.c,136 :: 		if(uart_string[k]=='K'){
	MOVF       _k+0, 0
	ADDLW      _uart_string+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      75
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;MyProject.c,139 :: 		UART1_Write_Text(uart_string);
	MOVLW      _uart_string+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,140 :: 		k++;
	INCF       _k+0, 1
	BTFSC      STATUS+0, 2
	INCF       _k+1, 1
;MyProject.c,142 :: 		k=0;
	CLRF       _k+0
	CLRF       _k+1
;MyProject.c,144 :: 		}
L_main6:
;MyProject.c,145 :: 		k++;
	INCF       _k+0, 1
	BTFSC      STATUS+0, 2
	INCF       _k+1, 1
;MyProject.c,146 :: 		}
L_main5:
;MyProject.c,149 :: 		if (uart_rd == 'A') { shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA; }  //PORTA.RA3 =1;  // bitwise OR kora hoyese..
	MOVF       _uart_rd+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main7
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
L_main7:
;MyProject.c,150 :: 		if (uart_rd == 'B') { shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA3 = 0;  firste bitwise AND kore then bitsie XOR kora hoyuese.
	MOVF       _uart_rd+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main8
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
L_main8:
;MyProject.c,151 :: 		if (uart_rd == 'C') { shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;} //PORTA.RA4 = 1
	MOVF       _uart_rd+0, 0
	XORLW      67
	BTFSS      STATUS+0, 2
	GOTO       L_main9
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
L_main9:
;MyProject.c,152 :: 		if (uart_rd == 'D') { shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;} //PORTA.RA4 = 0
	MOVF       _uart_rd+0, 0
	XORLW      68
	BTFSS      STATUS+0, 2
	GOTO       L_main10
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
L_main10:
;MyProject.c,155 :: 		if (uart_rd == 'E') { shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;}  //PORTA.RA2 =1
	MOVF       _uart_rd+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main11
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
L_main11:
;MyProject.c,156 :: 		if (uart_rd == 'F') { shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA2 = 0;
	MOVF       _uart_rd+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L_main12
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
L_main12:
;MyProject.c,158 :: 		if(uart_rd =='1'){Dimtime = 10;}
	MOVF       _uart_rd+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVLW      10
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main13:
;MyProject.c,159 :: 		if(uart_rd =='2'){Dimtime = 22;}
	MOVF       _uart_rd+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main14
	MOVLW      22
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main14:
;MyProject.c,160 :: 		if(uart_rd =='3'){Dimtime = 33;}
	MOVF       _uart_rd+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main15
	MOVLW      33
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main15:
;MyProject.c,161 :: 		if(uart_rd =='4'){Dimtime = 66;}
	MOVF       _uart_rd+0, 0
	XORLW      52
	BTFSS      STATUS+0, 2
	GOTO       L_main16
	MOVLW      66
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main16:
;MyProject.c,162 :: 		if(uart_rd =='5'){Dimtime = 88;}
	MOVF       _uart_rd+0, 0
	XORLW      53
	BTFSS      STATUS+0, 2
	GOTO       L_main17
	MOVLW      88
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main17:
;MyProject.c,163 :: 		if(uart_rd =='6'){Dimtime = 120;}
	MOVF       _uart_rd+0, 0
	XORLW      54
	BTFSS      STATUS+0, 2
	GOTO       L_main18
	MOVLW      120
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main18:
;MyProject.c,164 :: 		if(uart_rd =='7'){Dimtime = 150;}
	MOVF       _uart_rd+0, 0
	XORLW      55
	BTFSS      STATUS+0, 2
	GOTO       L_main19
	MOVLW      150
	MOVWF      _DimTime+0
	CLRF       _DimTime+1
L_main19:
;MyProject.c,165 :: 		if(uart_rd =='8'){Dimtime = 0;}
	MOVF       _uart_rd+0, 0
	XORLW      56
	BTFSS      STATUS+0, 2
	GOTO       L_main20
	CLRF       _DimTime+0
	CLRF       _DimTime+1
L_main20:
;MyProject.c,166 :: 		uart_rd = 0;
	CLRF       _uart_rd+0
;MyProject.c,169 :: 		if(CompMatch == 1) {
	MOVLW      0
	XORWF      _CompMatch+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main59
	MOVLW      1
	XORWF      _CompMatch+0, 0
L__main59:
	BTFSS      STATUS+0, 2
	GOTO       L_main21
;MyProject.c,170 :: 		CompMatch=0;
	CLRF       _CompMatch+0
	CLRF       _CompMatch+1
;MyProject.c,171 :: 		if (ZC){ //zero crossing occurred
	BTFSS      _FlagReg+0, 0
	GOTO       L_main22
;MyProject.c,172 :: 		if(DimTime == 1) {
	MOVLW      0
	XORWF      _DimTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main60
	MOVLW      1
	XORWF      _DimTime+0, 0
L__main60:
	BTFSS      STATUS+0, 2
	GOTO       L_main23
;MyProject.c,174 :: 		shadow_PORTB = shadow_PORTB|8; PORTB = shadow_PORTB; //RB3 on
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
;MyProject.c,176 :: 		}
L_main23:
;MyProject.c,177 :: 		if(Dimtime == 0) {
	MOVLW      0
	XORWF      _DimTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main61
	MOVLW      0
	XORWF      _DimTime+0, 0
L__main61:
	BTFSS      STATUS+0, 2
	GOTO       L_main24
;MyProject.c,179 :: 		shadow_PORTB = ((shadow_PORTB & 8) ^ shadow_PORTB); PORTB = shadow_PORTB;
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
;MyProject.c,180 :: 		} else {
	GOTO       L_main25
L_main24:
;MyProject.c,181 :: 		if(i>=DimTime) {
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _DimTime+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main62
	MOVF       _DimTime+0, 0
	SUBWF      _i+0, 0
L__main62:
	BTFSS      STATUS+0, 0
	GOTO       L_main26
;MyProject.c,183 :: 		shadow_PORTB = shadow_PORTB|8; PORTB = shadow_PORTB;
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
;MyProject.c,184 :: 		}
L_main26:
;MyProject.c,185 :: 		if(i>(DimTime+4)) {
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
	GOTO       L__main63
	MOVF       _i+0, 0
	SUBWF      R1+0, 0
L__main63:
	BTFSC      STATUS+0, 0
	GOTO       L_main27
;MyProject.c,186 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;MyProject.c,187 :: 		ZC=0;
	BCF        _FlagReg+0, 0
;MyProject.c,189 :: 		shadow_PORTB = ((shadow_PORTB & 8) ^ shadow_PORTB); PORTB = shadow_PORTB;
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
;MyProject.c,190 :: 		}
	GOTO       L_main28
L_main27:
;MyProject.c,192 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,193 :: 		}
L_main28:
;MyProject.c,194 :: 		}
L_main25:
;MyProject.c,195 :: 		}
L_main22:
;MyProject.c,196 :: 		}
L_main21:
;MyProject.c,200 :: 		if(PORTA.RA0 == 1) {
	BTFSS      PORTA+0, 0
	GOTO       L_main29
;MyProject.c,201 :: 		if(isButtonPressed1 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVLW      0
	XORWF      _isButtonPressed1+0, 0
L__main64:
	BTFSS      STATUS+0, 2
	GOTO       L_main30
;MyProject.c,202 :: 		DimTime = DimTime+10;
	MOVLW      10
	ADDWF      _DimTime+0, 1
	BTFSC      STATUS+0, 0
	INCF       _DimTime+1, 1
;MyProject.c,203 :: 		isButtonPressed1 =1;
	MOVLW      1
	MOVWF      _isButtonPressed1+0
	MOVLW      0
	MOVWF      _isButtonPressed1+1
;MyProject.c,205 :: 		}
L_main30:
;MyProject.c,206 :: 		}else {
	GOTO       L_main31
L_main29:
;MyProject.c,207 :: 		isButtonPressed1=0;
	CLRF       _isButtonPressed1+0
	CLRF       _isButtonPressed1+1
;MyProject.c,209 :: 		}
L_main31:
;MyProject.c,211 :: 		if(RA1_bit) {
	BTFSS      RA1_bit+0, BitPos(RA1_bit+0)
	GOTO       L_main32
;MyProject.c,212 :: 		if(isButtonPressed2 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVLW      0
	XORWF      _isButtonPressed2+0, 0
L__main65:
	BTFSS      STATUS+0, 2
	GOTO       L_main33
;MyProject.c,213 :: 		DimTime = DimTime-10;
	MOVLW      10
	SUBWF      _DimTime+0, 1
	BTFSS      STATUS+0, 0
	DECF       _DimTime+1, 1
;MyProject.c,214 :: 		isButtonPressed2 =1;
	MOVLW      1
	MOVWF      _isButtonPressed2+0
	MOVLW      0
	MOVWF      _isButtonPressed2+1
;MyProject.c,216 :: 		}
L_main33:
;MyProject.c,217 :: 		}else {
	GOTO       L_main34
L_main32:
;MyProject.c,218 :: 		isButtonPressed2=0;
	CLRF       _isButtonPressed2+0
	CLRF       _isButtonPressed2+1
;MyProject.c,220 :: 		}
L_main34:
;MyProject.c,222 :: 		if(RB7_bit) {
	BTFSS      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L_main35
;MyProject.c,223 :: 		if(isButtonPressed3 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVLW      0
	XORWF      _isButtonPressed3+0, 0
L__main66:
	BTFSS      STATUS+0, 2
	GOTO       L_main36
;MyProject.c,224 :: 		isButtonPressed3 =1;
	MOVLW      1
	MOVWF      _isButtonPressed3+0
	MOVLW      0
	MOVWF      _isButtonPressed3+1
;MyProject.c,225 :: 		if(isButtonOn ==0) {
	MOVLW      0
	XORWF      _isButtonOn+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main67
	MOVLW      0
	XORWF      _isButtonOn+0, 0
L__main67:
	BTFSS      STATUS+0, 2
	GOTO       L_main37
;MyProject.c,226 :: 		isButtonOn = 1;
	MOVLW      1
	MOVWF      _isButtonOn+0
	MOVLW      0
	MOVWF      _isButtonOn+1
;MyProject.c,228 :: 		shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA;
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
;MyProject.c,230 :: 		}
	GOTO       L_main38
L_main37:
;MyProject.c,232 :: 		isButtonOn = 0;
	CLRF       _isButtonOn+0
	CLRF       _isButtonOn+1
;MyProject.c,234 :: 		shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;
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
;MyProject.c,235 :: 		}
L_main38:
;MyProject.c,237 :: 		}
L_main36:
;MyProject.c,238 :: 		}else {
	GOTO       L_main39
L_main35:
;MyProject.c,239 :: 		isButtonPressed3=0;
	CLRF       _isButtonPressed3+0
	CLRF       _isButtonPressed3+1
;MyProject.c,240 :: 		}
L_main39:
;MyProject.c,242 :: 		if(RB6_bit) {
	BTFSS      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L_main40
;MyProject.c,243 :: 		if(isButtonPressed4 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed4+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main68
	MOVLW      0
	XORWF      _isButtonPressed4+0, 0
L__main68:
	BTFSS      STATUS+0, 2
	GOTO       L_main41
;MyProject.c,244 :: 		isButtonPressed4 =1;
	MOVLW      1
	MOVWF      _isButtonPressed4+0
	MOVLW      0
	MOVWF      _isButtonPressed4+1
;MyProject.c,245 :: 		if(isButtonOn2 ==0) {
	MOVLW      0
	XORWF      _isButtonOn2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main69
	MOVLW      0
	XORWF      _isButtonOn2+0, 0
L__main69:
	BTFSS      STATUS+0, 2
	GOTO       L_main42
;MyProject.c,246 :: 		isButtonOn2 = 1;
	MOVLW      1
	MOVWF      _isButtonOn2+0
	MOVLW      0
	MOVWF      _isButtonOn2+1
;MyProject.c,248 :: 		shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;
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
;MyProject.c,249 :: 		}
	GOTO       L_main43
L_main42:
;MyProject.c,251 :: 		isButtonOn2 = 0;
	CLRF       _isButtonOn2+0
	CLRF       _isButtonOn2+1
;MyProject.c,253 :: 		shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;
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
;MyProject.c,254 :: 		}
L_main43:
;MyProject.c,256 :: 		}
L_main41:
;MyProject.c,257 :: 		}else {
	GOTO       L_main44
L_main40:
;MyProject.c,258 :: 		isButtonPressed4=0;
	CLRF       _isButtonPressed4+0
	CLRF       _isButtonPressed4+1
;MyProject.c,259 :: 		}
L_main44:
;MyProject.c,261 :: 		if(RB5_bit) {
	BTFSS      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_main45
;MyProject.c,262 :: 		if(isButtonPressed5 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed5+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVLW      0
	XORWF      _isButtonPressed5+0, 0
L__main70:
	BTFSS      STATUS+0, 2
	GOTO       L_main46
;MyProject.c,263 :: 		isButtonPressed5 =1;
	MOVLW      1
	MOVWF      _isButtonPressed5+0
	MOVLW      0
	MOVWF      _isButtonPressed5+1
;MyProject.c,264 :: 		if(isButtonOn3 ==0) {
	MOVLW      0
	XORWF      _isButtonOn3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVLW      0
	XORWF      _isButtonOn3+0, 0
L__main71:
	BTFSS      STATUS+0, 2
	GOTO       L_main47
;MyProject.c,265 :: 		isButtonOn3 = 1;
	MOVLW      1
	MOVWF      _isButtonOn3+0
	MOVLW      0
	MOVWF      _isButtonOn3+1
;MyProject.c,267 :: 		shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;
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
;MyProject.c,268 :: 		}
	GOTO       L_main48
L_main47:
;MyProject.c,270 :: 		isButtonOn3 = 0;
	CLRF       _isButtonOn3+0
	CLRF       _isButtonOn3+1
;MyProject.c,272 :: 		shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;
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
;MyProject.c,273 :: 		}
L_main48:
;MyProject.c,275 :: 		}
L_main46:
;MyProject.c,276 :: 		}else {
	GOTO       L_main49
L_main45:
;MyProject.c,277 :: 		isButtonPressed5=0;
	CLRF       _isButtonPressed5+0
	CLRF       _isButtonPressed5+1
;MyProject.c,278 :: 		}
L_main49:
;MyProject.c,280 :: 		if(RB4_bit) {
	BTFSS      RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L_main50
;MyProject.c,281 :: 		if(isButtonPressed6 == 0) {
	MOVLW      0
	XORWF      _isButtonPressed6+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVLW      0
	XORWF      _isButtonPressed6+0, 0
L__main72:
	BTFSS      STATUS+0, 2
	GOTO       L_main51
;MyProject.c,282 :: 		isButtonPressed6 =1;
	MOVLW      1
	MOVWF      _isButtonPressed6+0
	MOVLW      0
	MOVWF      _isButtonPressed6+1
;MyProject.c,283 :: 		if(isButtonOn4 ==0) {
	MOVLW      0
	XORWF      _isButtonOn4+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main73
	MOVLW      0
	XORWF      _isButtonOn4+0, 0
L__main73:
	BTFSS      STATUS+0, 2
	GOTO       L_main52
;MyProject.c,284 :: 		isButtonOn4 = 1;
	MOVLW      1
	MOVWF      _isButtonOn4+0
	MOVLW      0
	MOVWF      _isButtonOn4+1
;MyProject.c,286 :: 		}
	GOTO       L_main53
L_main52:
;MyProject.c,288 :: 		isButtonOn4 = 0;
	CLRF       _isButtonOn4+0
	CLRF       _isButtonOn4+1
;MyProject.c,290 :: 		}
L_main53:
;MyProject.c,292 :: 		}
L_main51:
;MyProject.c,293 :: 		}else {
	GOTO       L_main54
L_main50:
;MyProject.c,294 :: 		isButtonPressed6=0;
	CLRF       _isButtonPressed6+0
	CLRF       _isButtonPressed6+1
;MyProject.c,295 :: 		}
L_main54:
;MyProject.c,297 :: 		}
	GOTO       L_main3
;MyProject.c,298 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
