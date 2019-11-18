#line 1 "E:/Arduino Works 02.02.2017/Home_Auto_All/16F72 softUART and Control Sys/Full System shorter version/New_16F628/MikroC Problem test/problemTest.c"
char uart_rd;
int shadow_PORTA =0;

void InitMain() {
TRISA = 0x00;
PORTA = 0;
TRISB = 0x03;
PORTB =0;

 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Start");
 UART1_Write(10);
 UART1_Write(13);

}

void main() {
 InitMain();

 while(1) {
 if (UART1_Data_Ready()) {
 uart_rd = UART1_Read();
 UART1_Write(uart_rd);
 }


 if (uart_rd == 'A') { shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA; }
 if (uart_rd == 'B') { shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;}
 if (uart_rd == 'C') { shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;}
 if (uart_rd == 'D') { shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;}


 if (uart_rd == 'E') { shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;}
 if (uart_rd == 'F') { shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;}

 uart_rd = 0;
 }
}
