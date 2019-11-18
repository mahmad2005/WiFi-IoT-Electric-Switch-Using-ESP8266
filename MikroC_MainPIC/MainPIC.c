char i, error, byte_read;                 // Auxiliary variables
char txt[6];
char utext =0;
char keyLoad ='0';

// keypad connection set
sbit row_A at RB4_bit;
sbit row_B at RB5_bit;
sbit row_C at RB6_bit;
sbit row_D at RB7_bit;


 sbit col_1 at RB0_bit;
 sbit col_2 at RB1_bit;
 sbit col_3 at RB2_bit;
 sbit col_4 at RB3_bit;
 //End keypad connection


char read_keypad()
                    {
                    PORTB = 0x10;
                    delay_ms(1);
                    if(col_1){return '1';}
                    else if(col_2){return '2';}
                    else if(col_3){return '3';}
                    else if(col_4){return 'A';}

                    PORTB = 0x20;
                    delay_ms(1);
                    if(col_1){return '4';}
                    else if(col_2){return '5';}
                    else if(col_3){return '6';}
                    else if(col_4){return 'B';}

                    PORTB = 0x40;
                    delay_ms(1);
                    if(col_1){return '7';}
                    else if(col_2){return '8';}
                    else if(col_3){return '9';}
                    else if(col_4){return 'C';}

                    PORTB = 0x80;
                    delay_ms(1);
                    if(col_1){return 'E';}
                    else if(col_2){return '0';}
                    else if(col_3){return 'F';}
                    else if(col_4){return 'D';}
                    
                    else{return 0xFF;}
            }

void intMain() {
 TRISC =0x00;
 PORTC =0;
 //TRISC.RC7=1;

  //ANSEL  = 0;                             // Configure AN pins as digital I/O
  //ANSELH = 0;
  ADCON0.ADON =0;  //ADC off
  ADCON1 =0xff; // declear all PORTA pin as Digital I/O // eita na korle UART kaj korbe nah PORTA te
  
  TRISA.RA2 = 0;
  TRISA.RA3 = 0;
  TRISA.RA4 = 0; // a pull up resistor with VDD voltage is need to make this work as a digital output ei pin kaj korano jabe nah. jhamela ase
  TRISA.RA5 = 0;
  PORTA=0;
  
  /*
  T0CS_bit=0;         // disable T0 (not necessary)
  T0SE_bit=1;         // disable T0 (not necessary)
  OPTION_REG.T0CS = 0;
  OPTION_REG.T0SE = 1;
  */

  TRISB = 0x0F;                           // Set PORTB as output (error signalization)
  PORTB = 0xF0;                              // No error
  
    error = Soft_UART_Init(&PORTA, 0, 1, 9600, 0); // Initialize Soft UART at 14400 bps
  if (error > 0) {
    //PORTB = error;                        // Signalize Init error
    while(1) ;                            // Stop program
  }
  Delay_ms(100);



}

void main(){
     intMain();

  for (i = 'z'; i >= 'A'; i--) {          // Send bytes from 'z' downto 'A'
    Soft_UART_Write(i);
    Delay_ms(100);
  }

  while(1) {                              // Endless loop
   //PORTA.RA4=1;
  
    keyLoad = read_keypad();
  
    if(keyLoad != 0xff) {
    byte_read = keyLoad;
    //PORTC.RC1=1;
     if(keyLoad =='1') {PORTA.RA2=1;}
     if(keyLoad =='2') {PORTA.RA2=0;}
     if(keyLoad =='4') {PORTA.RA3=1;}
     if(keyLoad =='5') {PORTA.RA3=0;}
     if(keyLoad =='7') {PORTA.RA4=1;}
     if(keyLoad =='8') {PORTA.RA4=0;}
     if(keyLoad =='E') {PORTA.RA5=1;}
     if(keyLoad =='0') {PORTA.RA5=0;}
     
     if(keyLoad =='3') {PORTC = 1;}
     if(keyLoad =='A') {PORTC = 33;}
     if(keyLoad =='6') {PORTC = 66;}
     if(keyLoad =='B') {PORTC = 99;}
     if(keyLoad =='9') {PORTC = 132;}
     if(keyLoad =='C') {PORTC = 165;}
     if(keyLoad =='F') {PORTC = 180;}
     if(keyLoad =='D') {PORTC = 0;}
     
     
    //WordToStr(keyLoad, txt);
    Soft_UART_Write(read_keypad());
    }
    //Soft_UART_Write(keyLoad);

   // byte_read = Soft_UART_Read(&error);   // Read byte, then test error flag
    //if (!byte_read){}                            // If error was detected
      //PORTB = error;                      //   signal it on PORTB
    //else
    //  Soft_UART_Write(byte_read);         // If error was not detected, return byte read
    }
}