
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;fourMhzTestproj4VBoard.c,32 :: 		void interrupt(){
;fourMhzTestproj4VBoard.c,33 :: 		if (INTCON.INTF){          //INTF flag raised, so external interrupt occured
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt0
;fourMhzTestproj4VBoard.c,34 :: 		ZC = 1;
	MOVLW      1
	MOVWF      _ZC+0
	MOVLW      0
	MOVWF      _ZC+1
;fourMhzTestproj4VBoard.c,35 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;fourMhzTestproj4VBoard.c,37 :: 		INTCON.INTF = 0;
	BCF        INTCON+0, 1
;fourMhzTestproj4VBoard.c,38 :: 		dimCounter=0;
	CLRF       _DimCounter+0
	CLRF       _DimCounter+1
;fourMhzTestproj4VBoard.c,39 :: 		}
L_interrupt0:
;fourMhzTestproj4VBoard.c,40 :: 		if(PIR1.CCP1IF) {
	BTFSS      PIR1+0, 2
	GOTO       L_interrupt1
;fourMhzTestproj4VBoard.c,42 :: 		PIR1.CCP1IF =0;
	BCF        PIR1+0, 2
;fourMhzTestproj4VBoard.c,43 :: 		PIR1.TMR1IF =0;
	BCF        PIR1+0, 0
;fourMhzTestproj4VBoard.c,44 :: 		CompMatch = 1;
	MOVLW      1
	MOVWF      _CompMatch+0
	MOVLW      0
	MOVWF      _CompMatch+1
;fourMhzTestproj4VBoard.c,45 :: 		TMR1L=0;
	CLRF       TMR1L+0
;fourMhzTestproj4VBoard.c,46 :: 		TMR1H=0;
	CLRF       TMR1H+0
;fourMhzTestproj4VBoard.c,47 :: 		}
L_interrupt1:
;fourMhzTestproj4VBoard.c,48 :: 		}
L_end_interrupt:
L__interrupt29:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_InitMain:

;fourMhzTestproj4VBoard.c,51 :: 		void InitMain() {
;fourMhzTestproj4VBoard.c,52 :: 		PORTA=0;
	CLRF       PORTA+0
;fourMhzTestproj4VBoard.c,53 :: 		TRISA=0x00;
	CLRF       TRISA+0
;fourMhzTestproj4VBoard.c,54 :: 		TRISA.RB0=1;
	BSF        TRISA+0, 0
;fourMhzTestproj4VBoard.c,55 :: 		TRISA.RB1=1;
	BSF        TRISA+0, 1
;fourMhzTestproj4VBoard.c,56 :: 		TRISA.RB2=0;
	BCF        TRISA+0, 2
;fourMhzTestproj4VBoard.c,57 :: 		TRISA.RB3=0;
	BCF        TRISA+0, 3
;fourMhzTestproj4VBoard.c,58 :: 		TRISA.RB4=0;
	BCF        TRISA+0, 4
;fourMhzTestproj4VBoard.c,59 :: 		TRISA.RA5=0;
	BCF        TRISA+0, 5
;fourMhzTestproj4VBoard.c,62 :: 		TRISB=0x03;  // rx pin musb be set input. otherwise it will not work
	MOVLW      3
	MOVWF      TRISB+0
;fourMhzTestproj4VBoard.c,63 :: 		TRISB.RB3=0;
	BCF        TRISB+0, 3
;fourMhzTestproj4VBoard.c,64 :: 		TRISB.RB4=1;
	BSF        TRISB+0, 4
;fourMhzTestproj4VBoard.c,65 :: 		TRISB.RB5=1;
	BSF        TRISB+0, 5
;fourMhzTestproj4VBoard.c,66 :: 		TRISB.RB6=1;
	BSF        TRISB+0, 6
;fourMhzTestproj4VBoard.c,67 :: 		TRISB.RB7=1;
	BSF        TRISB+0, 7
;fourMhzTestproj4VBoard.c,68 :: 		PORTB=0;
	CLRF       PORTB+0
;fourMhzTestproj4VBoard.c,72 :: 		OPTION_REG.INTEDG = 1;      //interrupt on falling edge
	BSF        OPTION_REG+0, 6
;fourMhzTestproj4VBoard.c,73 :: 		INTCON.INTF = 0;           //clear interrupt flag
	BCF        INTCON+0, 1
;fourMhzTestproj4VBoard.c,74 :: 		INTCON.INTE = 1;           //enable external interrupt
	BSF        INTCON+0, 4
;fourMhzTestproj4VBoard.c,75 :: 		INTCON.GIE = 1;            //enable global interrupt
	BSF        INTCON+0, 7
;fourMhzTestproj4VBoard.c,76 :: 		INTCON.PEIE = 1; // enable periferal interrupt
	BSF        INTCON+0, 6
;fourMhzTestproj4VBoard.c,81 :: 		TMR1L =0;
	CLRF       TMR1L+0
;fourMhzTestproj4VBoard.c,82 :: 		TMR1H=0;
	CLRF       TMR1H+0
;fourMhzTestproj4VBoard.c,84 :: 		T1CON.T1CKPS1 = 0;
	BCF        T1CON+0, 5
;fourMhzTestproj4VBoard.c,85 :: 		T1CON.T1CKPS0 = 0;
	BCF        T1CON+0, 4
;fourMhzTestproj4VBoard.c,88 :: 		T1CON.TMR1CS =0; // timer1 Source clock. 0 = internal, 1 = external
	BCF        T1CON+0, 1
;fourMhzTestproj4VBoard.c,89 :: 		T1CON.TMR1ON=1;    //timer on bit
	BSF        T1CON+0, 0
;fourMhzTestproj4VBoard.c,91 :: 		PIE1.TMR1IE = 1; // timer overflow enable
	BSF        PIE1+0, 0
;fourMhzTestproj4VBoard.c,99 :: 		CCP1CON.CCP1M3 = 1;
	BSF        CCP1CON+0, 3
;fourMhzTestproj4VBoard.c,100 :: 		CCP1CON.CCP1M2 = 0;
	BCF        CCP1CON+0, 2
;fourMhzTestproj4VBoard.c,101 :: 		CCP1CON.CCP1M1 = 1;
	BSF        CCP1CON+0, 1
;fourMhzTestproj4VBoard.c,102 :: 		CCP1CON.CCP1M0 = 0;
	BCF        CCP1CON+0, 0
;fourMhzTestproj4VBoard.c,103 :: 		PIE1.CCP1IE =1;  // CCP1 interrupt enable bit
	BSF        PIE1+0, 2
;fourMhzTestproj4VBoard.c,106 :: 		CCPR1L =0x4B;
	MOVLW      75
	MOVWF      CCPR1L+0
;fourMhzTestproj4VBoard.c,107 :: 		CCPR1H =0x00;
	CLRF       CCPR1H+0
;fourMhzTestproj4VBoard.c,112 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;fourMhzTestproj4VBoard.c,113 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
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
;fourMhzTestproj4VBoard.c,115 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr1_fourMhzTestproj4VBoard+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;fourMhzTestproj4VBoard.c,116 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;fourMhzTestproj4VBoard.c,117 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;fourMhzTestproj4VBoard.c,120 :: 		}
L_end_InitMain:
	RETURN
; end of _InitMain

_main:

;fourMhzTestproj4VBoard.c,122 :: 		void main() {
;fourMhzTestproj4VBoard.c,123 :: 		InitMain();
	CALL       _InitMain+0
;fourMhzTestproj4VBoard.c,124 :: 		while(1) {
L_main3:
;fourMhzTestproj4VBoard.c,128 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main5
;fourMhzTestproj4VBoard.c,129 :: 		uart_rd = UART1_Read();     // read the received data,
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;fourMhzTestproj4VBoard.c,130 :: 		UART1_Write(uart_rd);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;fourMhzTestproj4VBoard.c,131 :: 		}
L_main5:
;fourMhzTestproj4VBoard.c,134 :: 		if (uart_rd == 'A') { PORTA.RB3 = 1;}
	MOVF       _uart_rd+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main6
	BSF        PORTA+0, 3
L_main6:
;fourMhzTestproj4VBoard.c,135 :: 		if (uart_rd == 'B') { PORTA.RB3 = 0;}
	MOVF       _uart_rd+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main7
	BCF        PORTA+0, 3
L_main7:
;fourMhzTestproj4VBoard.c,136 :: 		if (uart_rd == 'C') { PORTA.RB4 = 1;}
	MOVF       _uart_rd+0, 0
	XORLW      67
	BTFSS      STATUS+0, 2
	GOTO       L_main8
	BSF        PORTA+0, 4
L_main8:
;fourMhzTestproj4VBoard.c,137 :: 		if (uart_rd == 'D') { PORTA.RB4 = 0;}
	MOVF       _uart_rd+0, 0
	XORLW      68
	BTFSS      STATUS+0, 2
	GOTO       L_main9
	BCF        PORTA+0, 4
L_main9:
;fourMhzTestproj4VBoard.c,138 :: 		if (uart_rd == 'E') { PORTB.RB3 = 1;}
	MOVF       _uart_rd+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main10
	BSF        PORTB+0, 3
L_main10:
;fourMhzTestproj4VBoard.c,139 :: 		if (uart_rd == 'F') { PORTB.RB3 = 0;}
	MOVF       _uart_rd+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L_main11
	BCF        PORTB+0, 3
L_main11:
;fourMhzTestproj4VBoard.c,141 :: 		if(uart_rd =='1'){Dimtime = 10;}
	MOVF       _uart_rd+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main12
	MOVLW      10
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main12:
;fourMhzTestproj4VBoard.c,142 :: 		if(uart_rd =='2'){Dimtime = 22;}
	MOVF       _uart_rd+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVLW      22
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main13:
;fourMhzTestproj4VBoard.c,143 :: 		if(uart_rd =='3'){Dimtime = 33;}
	MOVF       _uart_rd+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main14
	MOVLW      33
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main14:
;fourMhzTestproj4VBoard.c,144 :: 		if(uart_rd =='4'){Dimtime = 66;}
	MOVF       _uart_rd+0, 0
	XORLW      52
	BTFSS      STATUS+0, 2
	GOTO       L_main15
	MOVLW      66
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main15:
;fourMhzTestproj4VBoard.c,145 :: 		if(uart_rd =='5'){Dimtime = 88;}
	MOVF       _uart_rd+0, 0
	XORLW      53
	BTFSS      STATUS+0, 2
	GOTO       L_main16
	MOVLW      88
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main16:
;fourMhzTestproj4VBoard.c,146 :: 		if(uart_rd =='6'){Dimtime = 120;}
	MOVF       _uart_rd+0, 0
	XORLW      54
	BTFSS      STATUS+0, 2
	GOTO       L_main17
	MOVLW      120
	MOVWF      _DimTime+0
	MOVLW      0
	MOVWF      _DimTime+1
L_main17:
;fourMhzTestproj4VBoard.c,147 :: 		if(uart_rd =='7'){Dimtime = 150;}
	MOVF       _uart_rd+0, 0
	XORLW      55
	BTFSS      STATUS+0, 2
	GOTO       L_main18
	MOVLW      150
	MOVWF      _DimTime+0
	CLRF       _DimTime+1
L_main18:
;fourMhzTestproj4VBoard.c,148 :: 		if(uart_rd =='8'){Dimtime = 0;}
	MOVF       _uart_rd+0, 0
	XORLW      56
	BTFSS      STATUS+0, 2
	GOTO       L_main19
	CLRF       _DimTime+0
	CLRF       _DimTime+1
L_main19:
;fourMhzTestproj4VBoard.c,149 :: 		uart_rd = 0;
	CLRF       _uart_rd+0
;fourMhzTestproj4VBoard.c,152 :: 		if(CompMatch == 1) {
	MOVLW      0
	XORWF      _CompMatch+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main32
	MOVLW      1
	XORWF      _CompMatch+0, 0
L__main32:
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;fourMhzTestproj4VBoard.c,153 :: 		CompMatch=0;
	CLRF       _CompMatch+0
	CLRF       _CompMatch+1
;fourMhzTestproj4VBoard.c,154 :: 		if (ZC==1){ //zero crossing occurred
	MOVLW      0
	XORWF      _ZC+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main33
	MOVLW      1
	XORWF      _ZC+0, 0
L__main33:
	BTFSS      STATUS+0, 2
	GOTO       L_main21
;fourMhzTestproj4VBoard.c,155 :: 		if(DimTime == 1) {
	MOVLW      0
	XORWF      _DimTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main34
	MOVLW      1
	XORWF      _DimTime+0, 0
L__main34:
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;fourMhzTestproj4VBoard.c,156 :: 		RA2_bit =1;
	BSF        RA2_bit+0, BitPos(RA2_bit+0)
;fourMhzTestproj4VBoard.c,157 :: 		}
L_main22:
;fourMhzTestproj4VBoard.c,158 :: 		if(Dimtime == 0) {
	MOVLW      0
	XORWF      _DimTime+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main35
	MOVLW      0
	XORWF      _DimTime+0, 0
L__main35:
	BTFSS      STATUS+0, 2
	GOTO       L_main23
;fourMhzTestproj4VBoard.c,159 :: 		RA2_bit = 0;
	BCF        RA2_bit+0, BitPos(RA2_bit+0)
;fourMhzTestproj4VBoard.c,160 :: 		} else {
	GOTO       L_main24
L_main23:
;fourMhzTestproj4VBoard.c,161 :: 		if(i>=DimTime) {
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _DimTime+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main36
	MOVF       _DimTime+0, 0
	SUBWF      _i+0, 0
L__main36:
	BTFSS      STATUS+0, 0
	GOTO       L_main25
;fourMhzTestproj4VBoard.c,162 :: 		RA2_bit = 1;
	BSF        RA2_bit+0, BitPos(RA2_bit+0)
;fourMhzTestproj4VBoard.c,163 :: 		}
L_main25:
;fourMhzTestproj4VBoard.c,164 :: 		if(i>(DimTime+4)) {
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
	GOTO       L__main37
	MOVF       _i+0, 0
	SUBWF      R1+0, 0
L__main37:
	BTFSC      STATUS+0, 0
	GOTO       L_main26
;fourMhzTestproj4VBoard.c,165 :: 		i=0;
	CLRF       _i+0
	CLRF       _i+1
;fourMhzTestproj4VBoard.c,166 :: 		ZC=0;
	CLRF       _ZC+0
	CLRF       _ZC+1
;fourMhzTestproj4VBoard.c,167 :: 		RA2_bit =0;
	BCF        RA2_bit+0, BitPos(RA2_bit+0)
;fourMhzTestproj4VBoard.c,168 :: 		}
	GOTO       L_main27
L_main26:
;fourMhzTestproj4VBoard.c,170 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;fourMhzTestproj4VBoard.c,171 :: 		}
L_main27:
;fourMhzTestproj4VBoard.c,172 :: 		}
L_main24:
;fourMhzTestproj4VBoard.c,173 :: 		}
L_main21:
;fourMhzTestproj4VBoard.c,174 :: 		}
L_main20:
;fourMhzTestproj4VBoard.c,269 :: 		}
	GOTO       L_main3
;fourMhzTestproj4VBoard.c,270 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
