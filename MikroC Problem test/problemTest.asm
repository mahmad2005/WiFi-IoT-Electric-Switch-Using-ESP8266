
_InitMain:

;problemTest.c,4 :: 		void InitMain() {
;problemTest.c,5 :: 		TRISA = 0x00;
	CLRF       TRISA+0
;problemTest.c,6 :: 		PORTA = 0;
	CLRF       PORTA+0
;problemTest.c,7 :: 		TRISB = 0x03;
	MOVLW      3
	MOVWF      TRISB+0
;problemTest.c,8 :: 		PORTB =0;
	CLRF       PORTB+0
;problemTest.c,10 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;problemTest.c,11 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_InitMain0:
	DECFSZ     R13+0, 1
	GOTO       L_InitMain0
	DECFSZ     R12+0, 1
	GOTO       L_InitMain0
	DECFSZ     R11+0, 1
	GOTO       L_InitMain0
	NOP
;problemTest.c,13 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr1_problemTest+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;problemTest.c,14 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;problemTest.c,15 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;problemTest.c,17 :: 		}
L_end_InitMain:
	RETURN
; end of _InitMain

_main:

;problemTest.c,19 :: 		void main() {
;problemTest.c,20 :: 		InitMain();
	CALL       _InitMain+0
;problemTest.c,22 :: 		while(1) {
L_main1:
;problemTest.c,23 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;problemTest.c,24 :: 		uart_rd = UART1_Read();     // read the received data,
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _uart_rd+0
;problemTest.c,25 :: 		UART1_Write(uart_rd);
	MOVF       R0+0, 0
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;problemTest.c,26 :: 		}
L_main3:
;problemTest.c,29 :: 		if (uart_rd == 'A') { shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA; }  //PORTA.RA3 =1;  // bitwise OR kora hoyese..
	MOVF       _uart_rd+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main4
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
L_main4:
;problemTest.c,30 :: 		if (uart_rd == 'B') { shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA3 = 0;  firste bitwise AND kore then bitsie XOR kora hoyuese.
	MOVF       _uart_rd+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main5
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
L_main5:
;problemTest.c,31 :: 		if (uart_rd == 'C') { shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;} //PORTA.RA4 = 1
	MOVF       _uart_rd+0, 0
	XORLW      67
	BTFSS      STATUS+0, 2
	GOTO       L_main6
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
L_main6:
;problemTest.c,32 :: 		if (uart_rd == 'D') { shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;} //PORTA.RA4 = 0
	MOVF       _uart_rd+0, 0
	XORLW      68
	BTFSS      STATUS+0, 2
	GOTO       L_main7
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
L_main7:
;problemTest.c,35 :: 		if (uart_rd == 'E') { shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;}  //PORTA.RA2 =1
	MOVF       _uart_rd+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main8
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
L_main8:
;problemTest.c,36 :: 		if (uart_rd == 'F') { shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA2 = 0;
	MOVF       _uart_rd+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L_main9
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
L_main9:
;problemTest.c,38 :: 		uart_rd = 0;
	CLRF       _uart_rd+0
;problemTest.c,39 :: 		}
	GOTO       L_main1
;problemTest.c,40 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
