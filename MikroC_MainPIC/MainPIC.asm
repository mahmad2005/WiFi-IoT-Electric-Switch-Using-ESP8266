
_read_keypad:

;MainPIC.c,20 :: 		char read_keypad()
;MainPIC.c,22 :: 		PORTB = 0x10;
	MOVLW      16
	MOVWF      PORTB+0
;MainPIC.c,23 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_read_keypad0:
	DECFSZ     R13+0, 1
	GOTO       L_read_keypad0
	DECFSZ     R12+0, 1
	GOTO       L_read_keypad0
	NOP
	NOP
;MainPIC.c,24 :: 		if(col_1){return '1';}
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_keypad1
	MOVLW      49
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad1:
;MainPIC.c,25 :: 		else if(col_2){return '2';}
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_read_keypad3
	MOVLW      50
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad3:
;MainPIC.c,26 :: 		else if(col_3){return '3';}
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_read_keypad5
	MOVLW      51
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad5:
;MainPIC.c,27 :: 		else if(col_4){return 'A';}
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_read_keypad7
	MOVLW      65
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad7:
;MainPIC.c,29 :: 		PORTB = 0x20;
	MOVLW      32
	MOVWF      PORTB+0
;MainPIC.c,30 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_read_keypad8:
	DECFSZ     R13+0, 1
	GOTO       L_read_keypad8
	DECFSZ     R12+0, 1
	GOTO       L_read_keypad8
	NOP
	NOP
;MainPIC.c,31 :: 		if(col_1){return '4';}
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_keypad9
	MOVLW      52
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad9:
;MainPIC.c,32 :: 		else if(col_2){return '5';}
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_read_keypad11
	MOVLW      53
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad11:
;MainPIC.c,33 :: 		else if(col_3){return '6';}
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_read_keypad13
	MOVLW      54
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad13:
;MainPIC.c,34 :: 		else if(col_4){return 'B';}
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_read_keypad15
	MOVLW      66
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad15:
;MainPIC.c,36 :: 		PORTB = 0x40;
	MOVLW      64
	MOVWF      PORTB+0
;MainPIC.c,37 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_read_keypad16:
	DECFSZ     R13+0, 1
	GOTO       L_read_keypad16
	DECFSZ     R12+0, 1
	GOTO       L_read_keypad16
	NOP
	NOP
;MainPIC.c,38 :: 		if(col_1){return '7';}
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_keypad17
	MOVLW      55
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad17:
;MainPIC.c,39 :: 		else if(col_2){return '8';}
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_read_keypad19
	MOVLW      56
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad19:
;MainPIC.c,40 :: 		else if(col_3){return '9';}
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_read_keypad21
	MOVLW      57
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad21:
;MainPIC.c,41 :: 		else if(col_4){return 'C';}
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_read_keypad23
	MOVLW      67
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad23:
;MainPIC.c,43 :: 		PORTB = 0x80;
	MOVLW      128
	MOVWF      PORTB+0
;MainPIC.c,44 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_read_keypad24:
	DECFSZ     R13+0, 1
	GOTO       L_read_keypad24
	DECFSZ     R12+0, 1
	GOTO       L_read_keypad24
	NOP
	NOP
;MainPIC.c,45 :: 		if(col_1){return 'E';}
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_keypad25
	MOVLW      69
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad25:
;MainPIC.c,46 :: 		else if(col_2){return '0';}
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_read_keypad27
	MOVLW      48
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad27:
;MainPIC.c,47 :: 		else if(col_3){return 'F';}
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_read_keypad29
	MOVLW      70
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad29:
;MainPIC.c,48 :: 		else if(col_4){return 'D';}
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_read_keypad31
	MOVLW      68
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad31:
;MainPIC.c,50 :: 		else{return 0xFF;}
	MOVLW      255
	MOVWF      R0+0
;MainPIC.c,51 :: 		}
L_end_read_keypad:
	RETURN
; end of _read_keypad

_intMain:

;MainPIC.c,53 :: 		void intMain() {
;MainPIC.c,54 :: 		TRISC =0x00;
	CLRF       TRISC+0
;MainPIC.c,55 :: 		PORTC =0;
	CLRF       PORTC+0
;MainPIC.c,60 :: 		ADCON0.ADON =0;  //ADC off
	BCF        ADCON0+0, 0
;MainPIC.c,61 :: 		ADCON1 =0xff; // declear all PORTA pin as Digital I/O // eita na korle UART kaj korbe nah PORTA te
	MOVLW      255
	MOVWF      ADCON1+0
;MainPIC.c,63 :: 		TRISA.RA2 = 0;
	BCF        TRISA+0, 2
;MainPIC.c,64 :: 		TRISA.RA3 = 0;
	BCF        TRISA+0, 3
;MainPIC.c,65 :: 		TRISA.RA4 = 0; // a pull up resistor with VDD voltage is need to make this work as a digital output ei pin kaj korano jabe nah. jhamela ase
	BCF        TRISA+0, 4
;MainPIC.c,66 :: 		TRISA.RA5 = 0;
	BCF        TRISA+0, 5
;MainPIC.c,67 :: 		PORTA=0;
	CLRF       PORTA+0
;MainPIC.c,76 :: 		TRISB = 0x0F;                           // Set PORTB as output (error signalization)
	MOVLW      15
	MOVWF      TRISB+0
;MainPIC.c,77 :: 		PORTB = 0xF0;                              // No error
	MOVLW      240
	MOVWF      PORTB+0
;MainPIC.c,79 :: 		error = Soft_UART_Init(&PORTA, 0, 1, 9600, 0); // Initialize Soft UART at 14400 bps
	MOVLW      PORTA+0
	MOVWF      FARG_Soft_UART_Init_port+0
	CLRF       FARG_Soft_UART_Init_rx_pin+0
	MOVLW      1
	MOVWF      FARG_Soft_UART_Init_tx_pin+0
	MOVLW      128
	MOVWF      FARG_Soft_UART_Init_baud_rate+0
	MOVLW      37
	MOVWF      FARG_Soft_UART_Init_baud_rate+1
	CLRF       FARG_Soft_UART_Init_baud_rate+2
	CLRF       FARG_Soft_UART_Init_baud_rate+3
	CLRF       FARG_Soft_UART_Init_inverted+0
	CALL       _Soft_UART_Init+0
	MOVF       R0+0, 0
	MOVWF      _error+0
;MainPIC.c,80 :: 		if (error > 0) {
	MOVF       R0+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_intMain33
;MainPIC.c,82 :: 		while(1) ;                            // Stop program
L_intMain34:
	GOTO       L_intMain34
;MainPIC.c,83 :: 		}
L_intMain33:
;MainPIC.c,84 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_intMain36:
	DECFSZ     R13+0, 1
	GOTO       L_intMain36
	DECFSZ     R12+0, 1
	GOTO       L_intMain36
	DECFSZ     R11+0, 1
	GOTO       L_intMain36
	NOP
;MainPIC.c,88 :: 		}
L_end_intMain:
	RETURN
; end of _intMain

_main:

;MainPIC.c,90 :: 		void main(){
;MainPIC.c,91 :: 		intMain();
	CALL       _intMain+0
;MainPIC.c,93 :: 		for (i = 'z'; i >= 'A'; i--) {          // Send bytes from 'z' downto 'A'
	MOVLW      122
	MOVWF      _i+0
L_main37:
	MOVLW      65
	SUBWF      _i+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main38
;MainPIC.c,94 :: 		Soft_UART_Write(i);
	MOVF       _i+0, 0
	MOVWF      FARG_Soft_UART_Write_udata+0
	CALL       _Soft_UART_Write+0
;MainPIC.c,95 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	DECFSZ     R11+0, 1
	GOTO       L_main40
	NOP
;MainPIC.c,93 :: 		for (i = 'z'; i >= 'A'; i--) {          // Send bytes from 'z' downto 'A'
	DECF       _i+0, 1
;MainPIC.c,96 :: 		}
	GOTO       L_main37
L_main38:
;MainPIC.c,98 :: 		while(1) {                              // Endless loop
L_main41:
;MainPIC.c,101 :: 		keyLoad = read_keypad();
	CALL       _read_keypad+0
	MOVF       R0+0, 0
	MOVWF      _keyLoad+0
;MainPIC.c,103 :: 		if(keyLoad != 0xff) {
	MOVF       R0+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_main43
;MainPIC.c,104 :: 		byte_read = keyLoad;
	MOVF       _keyLoad+0, 0
	MOVWF      _byte_read+0
;MainPIC.c,106 :: 		if(keyLoad =='1') {PORTA.RA2=1;}
	MOVF       _keyLoad+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main44
	BSF        PORTA+0, 2
L_main44:
;MainPIC.c,107 :: 		if(keyLoad =='2') {PORTA.RA2=0;}
	MOVF       _keyLoad+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main45
	BCF        PORTA+0, 2
L_main45:
;MainPIC.c,108 :: 		if(keyLoad =='4') {PORTA.RA3=1;}
	MOVF       _keyLoad+0, 0
	XORLW      52
	BTFSS      STATUS+0, 2
	GOTO       L_main46
	BSF        PORTA+0, 3
L_main46:
;MainPIC.c,109 :: 		if(keyLoad =='5') {PORTA.RA3=0;}
	MOVF       _keyLoad+0, 0
	XORLW      53
	BTFSS      STATUS+0, 2
	GOTO       L_main47
	BCF        PORTA+0, 3
L_main47:
;MainPIC.c,110 :: 		if(keyLoad =='7') {PORTA.RA4=1;}
	MOVF       _keyLoad+0, 0
	XORLW      55
	BTFSS      STATUS+0, 2
	GOTO       L_main48
	BSF        PORTA+0, 4
L_main48:
;MainPIC.c,111 :: 		if(keyLoad =='8') {PORTA.RA4=0;}
	MOVF       _keyLoad+0, 0
	XORLW      56
	BTFSS      STATUS+0, 2
	GOTO       L_main49
	BCF        PORTA+0, 4
L_main49:
;MainPIC.c,112 :: 		if(keyLoad =='E') {PORTA.RA5=1;}
	MOVF       _keyLoad+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main50
	BSF        PORTA+0, 5
L_main50:
;MainPIC.c,113 :: 		if(keyLoad =='0') {PORTA.RA5=0;}
	MOVF       _keyLoad+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main51
	BCF        PORTA+0, 5
L_main51:
;MainPIC.c,115 :: 		if(keyLoad =='3') {PORTC = 1;}
	MOVF       _keyLoad+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main52
	MOVLW      1
	MOVWF      PORTC+0
L_main52:
;MainPIC.c,116 :: 		if(keyLoad =='A') {PORTC = 33;}
	MOVF       _keyLoad+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main53
	MOVLW      33
	MOVWF      PORTC+0
L_main53:
;MainPIC.c,117 :: 		if(keyLoad =='6') {PORTC = 66;}
	MOVF       _keyLoad+0, 0
	XORLW      54
	BTFSS      STATUS+0, 2
	GOTO       L_main54
	MOVLW      66
	MOVWF      PORTC+0
L_main54:
;MainPIC.c,118 :: 		if(keyLoad =='B') {PORTC = 99;}
	MOVF       _keyLoad+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main55
	MOVLW      99
	MOVWF      PORTC+0
L_main55:
;MainPIC.c,119 :: 		if(keyLoad =='9') {PORTC = 132;}
	MOVF       _keyLoad+0, 0
	XORLW      57
	BTFSS      STATUS+0, 2
	GOTO       L_main56
	MOVLW      132
	MOVWF      PORTC+0
L_main56:
;MainPIC.c,120 :: 		if(keyLoad =='C') {PORTC = 165;}
	MOVF       _keyLoad+0, 0
	XORLW      67
	BTFSS      STATUS+0, 2
	GOTO       L_main57
	MOVLW      165
	MOVWF      PORTC+0
L_main57:
;MainPIC.c,121 :: 		if(keyLoad =='F') {PORTC = 180;}
	MOVF       _keyLoad+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L_main58
	MOVLW      180
	MOVWF      PORTC+0
L_main58:
;MainPIC.c,122 :: 		if(keyLoad =='D') {PORTC = 0;}
	MOVF       _keyLoad+0, 0
	XORLW      68
	BTFSS      STATUS+0, 2
	GOTO       L_main59
	CLRF       PORTC+0
L_main59:
;MainPIC.c,126 :: 		Soft_UART_Write(read_keypad());
	CALL       _read_keypad+0
	MOVF       R0+0, 0
	MOVWF      FARG_Soft_UART_Write_udata+0
	CALL       _Soft_UART_Write+0
;MainPIC.c,127 :: 		}
L_main43:
;MainPIC.c,135 :: 		}
	GOTO       L_main41
;MainPIC.c,136 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
