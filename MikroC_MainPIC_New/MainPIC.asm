
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MainPIC.c,20 :: 		void interrupt(){
;MainPIC.c,21 :: 		if(PIR1.TMR1IF ==1){
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt0
;MainPIC.c,23 :: 		Soft_UART_Break();
	CALL       _Soft_UART_Break+0
;MainPIC.c,24 :: 		PIR1.TMR1IF =0;
	BCF        PIR1+0, 0
;MainPIC.c,25 :: 		TMR1L=0;
	CLRF       TMR1L+0
;MainPIC.c,26 :: 		TMR1H=0;
	CLRF       TMR1H+0
;MainPIC.c,27 :: 		}
L_interrupt0:
;MainPIC.c,28 :: 		}
L_end_interrupt:
L__interrupt73:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_read_keypad:

;MainPIC.c,31 :: 		char read_keypad()
;MainPIC.c,33 :: 		PORTB = 0x10;
	MOVLW      16
	MOVWF      PORTB+0
;MainPIC.c,34 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_read_keypad1:
	DECFSZ     R13+0, 1
	GOTO       L_read_keypad1
	DECFSZ     R12+0, 1
	GOTO       L_read_keypad1
	NOP
	NOP
;MainPIC.c,35 :: 		if(col_1){return '1';}
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_keypad2
	MOVLW      49
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad2:
;MainPIC.c,36 :: 		else if(col_2){return '2';}
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_read_keypad4
	MOVLW      50
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad4:
;MainPIC.c,37 :: 		else if(col_3){return '3';}
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_read_keypad6
	MOVLW      51
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad6:
;MainPIC.c,38 :: 		else if(col_4){return 'A';}
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_read_keypad8
	MOVLW      65
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad8:
;MainPIC.c,40 :: 		PORTB = 0x20;
	MOVLW      32
	MOVWF      PORTB+0
;MainPIC.c,41 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_read_keypad9:
	DECFSZ     R13+0, 1
	GOTO       L_read_keypad9
	DECFSZ     R12+0, 1
	GOTO       L_read_keypad9
	NOP
	NOP
;MainPIC.c,42 :: 		if(col_1){return '4';}
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_keypad10
	MOVLW      52
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad10:
;MainPIC.c,43 :: 		else if(col_2){return '5';}
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_read_keypad12
	MOVLW      53
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad12:
;MainPIC.c,44 :: 		else if(col_3){return '6';}
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_read_keypad14
	MOVLW      54
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad14:
;MainPIC.c,45 :: 		else if(col_4){return 'B';}
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_read_keypad16
	MOVLW      66
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad16:
;MainPIC.c,47 :: 		PORTB = 0x40;
	MOVLW      64
	MOVWF      PORTB+0
;MainPIC.c,48 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_read_keypad17:
	DECFSZ     R13+0, 1
	GOTO       L_read_keypad17
	DECFSZ     R12+0, 1
	GOTO       L_read_keypad17
	NOP
	NOP
;MainPIC.c,49 :: 		if(col_1){return '7';}
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_keypad18
	MOVLW      55
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad18:
;MainPIC.c,50 :: 		else if(col_2){return '8';}
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_read_keypad20
	MOVLW      56
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad20:
;MainPIC.c,51 :: 		else if(col_3){return '9';}
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_read_keypad22
	MOVLW      57
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad22:
;MainPIC.c,52 :: 		else if(col_4){return 'C';}
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_read_keypad24
	MOVLW      67
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad24:
;MainPIC.c,54 :: 		PORTB = 0x80;
	MOVLW      128
	MOVWF      PORTB+0
;MainPIC.c,55 :: 		delay_ms(1);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_read_keypad25:
	DECFSZ     R13+0, 1
	GOTO       L_read_keypad25
	DECFSZ     R12+0, 1
	GOTO       L_read_keypad25
	NOP
	NOP
;MainPIC.c,56 :: 		if(col_1){return 'E';}
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_read_keypad26
	MOVLW      69
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad26:
;MainPIC.c,57 :: 		else if(col_2){return '0';}
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_read_keypad28
	MOVLW      48
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad28:
;MainPIC.c,58 :: 		else if(col_3){return 'F';}
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_read_keypad30
	MOVLW      70
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad30:
;MainPIC.c,59 :: 		else if(col_4){return 'D';}
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_read_keypad32
	MOVLW      68
	MOVWF      R0+0
	GOTO       L_end_read_keypad
L_read_keypad32:
;MainPIC.c,61 :: 		else{return 0xFF;}
	MOVLW      255
	MOVWF      R0+0
;MainPIC.c,62 :: 		}
L_end_read_keypad:
	RETURN
; end of _read_keypad

_intMain:

;MainPIC.c,64 :: 		void intMain() {
;MainPIC.c,65 :: 		TRISC =0x00;
	CLRF       TRISC+0
;MainPIC.c,66 :: 		PORTC =0;
	CLRF       PORTC+0
;MainPIC.c,71 :: 		ADCON0.ADON =0;  //ADC off
	BCF        ADCON0+0, 0
;MainPIC.c,72 :: 		ADCON1 =0xff; // declear all PORTA pin as Digital I/O // eita na korle UART kaj korbe nah PORTA te
	MOVLW      255
	MOVWF      ADCON1+0
;MainPIC.c,74 :: 		TRISA.RA2 = 0;
	BCF        TRISA+0, 2
;MainPIC.c,75 :: 		TRISA.RA3 = 0;
	BCF        TRISA+0, 3
;MainPIC.c,76 :: 		TRISA.RA4 = 0; // a pull up resistor with VDD voltage is need to make this work as a digital output ei pin kaj korano jabe nah. jhamela ase
	BCF        TRISA+0, 4
;MainPIC.c,77 :: 		TRISA.RA5 = 0;
	BCF        TRISA+0, 5
;MainPIC.c,78 :: 		PORTA=0;
	CLRF       PORTA+0
;MainPIC.c,87 :: 		TRISB = 0x0F;                           // Set PORTB as output (error signalization)
	MOVLW      15
	MOVWF      TRISB+0
;MainPIC.c,88 :: 		PORTB = 0xF0;                              // No error
	MOVLW      240
	MOVWF      PORTB+0
;MainPIC.c,91 :: 		INTCON.PEIE = 1; // enable periferal interrupt
	BSF        INTCON+0, 6
;MainPIC.c,92 :: 		INTCON.INTF = 0;           //clear interrupt flag
	BCF        INTCON+0, 1
;MainPIC.c,93 :: 		INTCON.GIE = 1;  // enable global interrupt
	BSF        INTCON+0, 7
;MainPIC.c,97 :: 		T1CON.T1CKPS1 = 0;
	BCF        T1CON+0, 5
;MainPIC.c,98 :: 		T1CON.T1CKPS0 = 0;
	BCF        T1CON+0, 4
;MainPIC.c,100 :: 		T1CON.TMR1CS = 0; // internal clock uses
	BCF        T1CON+0, 1
;MainPIC.c,102 :: 		PIE1.TMR1IE = 1; // timeroverflow bit set
	BSF        PIE1+0, 0
;MainPIC.c,106 :: 		error = Soft_UART_Init(&PORTA, 0, 1, 9600, 0); // Initialize Soft UART at 14400 bps
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
;MainPIC.c,107 :: 		if (error > 0) {
	MOVF       R0+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_intMain34
;MainPIC.c,109 :: 		while(1) ;                            // Stop program
L_intMain35:
	GOTO       L_intMain35
;MainPIC.c,110 :: 		}
L_intMain34:
;MainPIC.c,111 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_intMain37:
	DECFSZ     R13+0, 1
	GOTO       L_intMain37
	DECFSZ     R12+0, 1
	GOTO       L_intMain37
	DECFSZ     R11+0, 1
	GOTO       L_intMain37
	NOP
;MainPIC.c,115 :: 		}
L_end_intMain:
	RETURN
; end of _intMain

_main:

;MainPIC.c,117 :: 		void main(){
;MainPIC.c,118 :: 		intMain();
	CALL       _intMain+0
;MainPIC.c,125 :: 		while(1) {                              // Endless loop
L_main38:
;MainPIC.c,128 :: 		keyLoad = read_keypad();
	CALL       _read_keypad+0
	MOVF       R0+0, 0
	MOVWF      _keyLoad+0
;MainPIC.c,130 :: 		if(keyLoad != 0xff) {
	MOVF       R0+0, 0
	XORLW      255
	BTFSC      STATUS+0, 2
	GOTO       L_main40
;MainPIC.c,131 :: 		byte_read = keyLoad;
	MOVF       _keyLoad+0, 0
	MOVWF      _byte_read+0
;MainPIC.c,133 :: 		if(keyLoad =='1') {PORTA.RA2=1;}
	MOVF       _keyLoad+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main41
	BSF        PORTA+0, 2
L_main41:
;MainPIC.c,134 :: 		if(keyLoad =='2') {PORTA.RA2=0;}
	MOVF       _keyLoad+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main42
	BCF        PORTA+0, 2
L_main42:
;MainPIC.c,135 :: 		if(keyLoad =='4') {PORTA.RA3=1;}
	MOVF       _keyLoad+0, 0
	XORLW      52
	BTFSS      STATUS+0, 2
	GOTO       L_main43
	BSF        PORTA+0, 3
L_main43:
;MainPIC.c,136 :: 		if(keyLoad =='5') {PORTA.RA3=0;}
	MOVF       _keyLoad+0, 0
	XORLW      53
	BTFSS      STATUS+0, 2
	GOTO       L_main44
	BCF        PORTA+0, 3
L_main44:
;MainPIC.c,137 :: 		if(keyLoad =='7') {PORTA.RA4=1;}
	MOVF       _keyLoad+0, 0
	XORLW      55
	BTFSS      STATUS+0, 2
	GOTO       L_main45
	BSF        PORTA+0, 4
L_main45:
;MainPIC.c,138 :: 		if(keyLoad =='8') {PORTA.RA4=0;}
	MOVF       _keyLoad+0, 0
	XORLW      56
	BTFSS      STATUS+0, 2
	GOTO       L_main46
	BCF        PORTA+0, 4
L_main46:
;MainPIC.c,139 :: 		if(keyLoad =='E') {PORTA.RA5=1;}
	MOVF       _keyLoad+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main47
	BSF        PORTA+0, 5
L_main47:
;MainPIC.c,140 :: 		if(keyLoad =='0') {PORTA.RA5=0;}
	MOVF       _keyLoad+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main48
	BCF        PORTA+0, 5
L_main48:
;MainPIC.c,142 :: 		if(keyLoad =='3') {PORTC = 1;}
	MOVF       _keyLoad+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main49
	MOVLW      1
	MOVWF      PORTC+0
L_main49:
;MainPIC.c,143 :: 		if(keyLoad =='A') {PORTC = 33;}
	MOVF       _keyLoad+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main50
	MOVLW      33
	MOVWF      PORTC+0
L_main50:
;MainPIC.c,144 :: 		if(keyLoad =='6') {PORTC = 66;}
	MOVF       _keyLoad+0, 0
	XORLW      54
	BTFSS      STATUS+0, 2
	GOTO       L_main51
	MOVLW      66
	MOVWF      PORTC+0
L_main51:
;MainPIC.c,145 :: 		if(keyLoad =='B') {PORTC = 99;}
	MOVF       _keyLoad+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main52
	MOVLW      99
	MOVWF      PORTC+0
L_main52:
;MainPIC.c,146 :: 		if(keyLoad =='9') {PORTC = 132;}
	MOVF       _keyLoad+0, 0
	XORLW      57
	BTFSS      STATUS+0, 2
	GOTO       L_main53
	MOVLW      132
	MOVWF      PORTC+0
L_main53:
;MainPIC.c,147 :: 		if(keyLoad =='C') {PORTC = 165;}
	MOVF       _keyLoad+0, 0
	XORLW      67
	BTFSS      STATUS+0, 2
	GOTO       L_main54
	MOVLW      165
	MOVWF      PORTC+0
L_main54:
;MainPIC.c,148 :: 		if(keyLoad =='F') {PORTC = 180;}
	MOVF       _keyLoad+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L_main55
	MOVLW      180
	MOVWF      PORTC+0
L_main55:
;MainPIC.c,149 :: 		if(keyLoad =='D') {PORTC = 0;}
	MOVF       _keyLoad+0, 0
	XORLW      68
	BTFSS      STATUS+0, 2
	GOTO       L_main56
	CLRF       PORTC+0
L_main56:
;MainPIC.c,154 :: 		}
L_main40:
;MainPIC.c,155 :: 		T1CON.TMR1ON = 1;
	BSF        T1CON+0, 0
;MainPIC.c,156 :: 		byte_read = Soft_UART_Read(&error);   // Read byte, then test error flag
	MOVLW      _error+0
	MOVWF      FARG_Soft_UART_Read_error+0
	CALL       _Soft_UART_Read+0
	MOVF       R0+0, 0
	MOVWF      _byte_read+0
;MainPIC.c,157 :: 		T1CON.TMR1ON = 0;
	BCF        T1CON+0, 0
;MainPIC.c,161 :: 		if (byte_read != 0) {
	MOVF       R0+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_main57
;MainPIC.c,162 :: 		if (byte_read == 'A') { PORTA.RA2 = 1;}
	MOVF       _byte_read+0, 0
	XORLW      65
	BTFSS      STATUS+0, 2
	GOTO       L_main58
	BSF        PORTA+0, 2
L_main58:
;MainPIC.c,163 :: 		if (byte_read == 'B') { PORTA.RA2 = 0;}
	MOVF       _byte_read+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main59
	BCF        PORTA+0, 2
L_main59:
;MainPIC.c,164 :: 		if (byte_read == 'C') { PORTA.RA3 = 1;}
	MOVF       _byte_read+0, 0
	XORLW      67
	BTFSS      STATUS+0, 2
	GOTO       L_main60
	BSF        PORTA+0, 3
L_main60:
;MainPIC.c,165 :: 		if (byte_read == 'D') { PORTA.RA3 = 0;}
	MOVF       _byte_read+0, 0
	XORLW      68
	BTFSS      STATUS+0, 2
	GOTO       L_main61
	BCF        PORTA+0, 3
L_main61:
;MainPIC.c,166 :: 		if (byte_read == 'E') { PORTA.RA5 = 1;}
	MOVF       _byte_read+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main62
	BSF        PORTA+0, 5
L_main62:
;MainPIC.c,167 :: 		if (byte_read == 'F') { PORTA.RA5 = 0;}
	MOVF       _byte_read+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L_main63
	BCF        PORTA+0, 5
L_main63:
;MainPIC.c,169 :: 		if(byte_read =='1') {PORTC = 1;}
	MOVF       _byte_read+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main64
	MOVLW      1
	MOVWF      PORTC+0
L_main64:
;MainPIC.c,170 :: 		if(byte_read =='2') {PORTC = 33;}
	MOVF       _byte_read+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main65
	MOVLW      33
	MOVWF      PORTC+0
L_main65:
;MainPIC.c,171 :: 		if(byte_read =='3') {PORTC = 66;}
	MOVF       _byte_read+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main66
	MOVLW      66
	MOVWF      PORTC+0
L_main66:
;MainPIC.c,172 :: 		if(byte_read =='4') {PORTC = 99;}
	MOVF       _byte_read+0, 0
	XORLW      52
	BTFSS      STATUS+0, 2
	GOTO       L_main67
	MOVLW      99
	MOVWF      PORTC+0
L_main67:
;MainPIC.c,173 :: 		if(byte_read =='5') {PORTC = 132;}
	MOVF       _byte_read+0, 0
	XORLW      53
	BTFSS      STATUS+0, 2
	GOTO       L_main68
	MOVLW      132
	MOVWF      PORTC+0
L_main68:
;MainPIC.c,174 :: 		if(byte_read =='6') {PORTC = 165;}
	MOVF       _byte_read+0, 0
	XORLW      54
	BTFSS      STATUS+0, 2
	GOTO       L_main69
	MOVLW      165
	MOVWF      PORTC+0
L_main69:
;MainPIC.c,175 :: 		if(byte_read =='7') {PORTC = 180;}
	MOVF       _byte_read+0, 0
	XORLW      55
	BTFSS      STATUS+0, 2
	GOTO       L_main70
	MOVLW      180
	MOVWF      PORTC+0
L_main70:
;MainPIC.c,176 :: 		if(byte_read =='8') {PORTC = 0;}
	MOVF       _byte_read+0, 0
	XORLW      56
	BTFSS      STATUS+0, 2
	GOTO       L_main71
	CLRF       PORTC+0
L_main71:
;MainPIC.c,180 :: 		}
L_main57:
;MainPIC.c,189 :: 		}
	GOTO       L_main38
;MainPIC.c,190 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
