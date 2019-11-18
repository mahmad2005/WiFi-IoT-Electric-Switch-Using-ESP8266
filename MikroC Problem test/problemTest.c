char uart_rd;
int shadow_PORTA =0;

void InitMain() {
TRISA = 0x00;
PORTA = 0;
TRISB = 0x03;
PORTB =0;

  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("Start");
  UART1_Write(10);
  UART1_Write(13);
  
}

void main() {
  InitMain();
 
 while(1) {
      if (UART1_Data_Ready()) {     // If data is received,
      uart_rd = UART1_Read();     // read the received data,
      UART1_Write(uart_rd);
    }


    if (uart_rd == 'A') { shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA; }  //PORTA.RA3 =1;  // bitwise OR kora hoyese..
    if (uart_rd == 'B') { shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA3 = 0;  firste bitwise AND kore then bitsie XOR kora hoyuese.
    if (uart_rd == 'C') { shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;} //PORTA.RA4 = 1
    if (uart_rd == 'D') { shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;} //PORTA.RA4 = 0
    //if (uart_rd == 'E') { PORTB.RB3 = 1;}
    //if (uart_rd == 'F') { PORTB.RB3 = 0;}
    if (uart_rd == 'E') { shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;}  //PORTA.RA2 =1
    if (uart_rd == 'F') { shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA2 = 0;

    uart_rd = 0;
 }
}