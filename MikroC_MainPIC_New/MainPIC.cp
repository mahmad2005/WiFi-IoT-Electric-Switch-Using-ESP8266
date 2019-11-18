#line 1 "E:/Arduino Works 02.02.2017/Home_Auto_All/16F72 softUART and Control Sys/Full System/MikroC_MainPIC_New/MainPIC.c"
char i, error, byte_read;
char txt[6];
char utext =0;
char keyLoad ='0';


sbit row_A at RB4_bit;
sbit row_B at RB5_bit;
sbit row_C at RB6_bit;
sbit row_D at RB7_bit;


 sbit col_1 at RB0_bit;
 sbit col_2 at RB1_bit;
 sbit col_3 at RB2_bit;
 sbit col_4 at RB3_bit;



 void interrupt(){
 if(PIR1.TMR1IF ==1){

 Soft_UART_Break();
 PIR1.TMR1IF =0;
 TMR1L=0;
 TMR1H=0;
 }
}


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




 ADCON0.ADON =0;
 ADCON1 =0xff;

 TRISA.RA2 = 0;
 TRISA.RA3 = 0;
 TRISA.RA4 = 0;
 TRISA.RA5 = 0;
 PORTA=0;
#line 87 "E:/Arduino Works 02.02.2017/Home_Auto_All/16F72 softUART and Control Sys/Full System/MikroC_MainPIC_New/MainPIC.c"
 TRISB = 0x0F;
 PORTB = 0xF0;


 INTCON.PEIE = 1;
 INTCON.INTF = 0;
 INTCON.GIE = 1;



 T1CON.T1CKPS1 = 0;
 T1CON.T1CKPS0 = 0;

 T1CON.TMR1CS = 0;

 PIE1.TMR1IE = 1;



 error = Soft_UART_Init(&PORTA, 0, 1, 9600, 0);
 if (error > 0) {

 while(1) ;
 }
 Delay_ms(100);



}

void main(){
 intMain();
#line 125 "E:/Arduino Works 02.02.2017/Home_Auto_All/16F72 softUART and Control Sys/Full System/MikroC_MainPIC_New/MainPIC.c"
 while(1) {


 keyLoad = read_keypad();

 if(keyLoad != 0xff) {
 byte_read = keyLoad;

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




 }
 T1CON.TMR1ON = 1;
 byte_read = Soft_UART_Read(&error);
 T1CON.TMR1ON = 0;



 if (byte_read != 0) {
 if (byte_read == 'A') { PORTA.RA2 = 1;}
 if (byte_read == 'B') { PORTA.RA2 = 0;}
 if (byte_read == 'C') { PORTA.RA3 = 1;}
 if (byte_read == 'D') { PORTA.RA3 = 0;}
 if (byte_read == 'E') { PORTA.RA5 = 1;}
 if (byte_read == 'F') { PORTA.RA5 = 0;}

 if(byte_read =='1') {PORTC = 1;}
 if(byte_read =='2') {PORTC = 33;}
 if(byte_read =='3') {PORTC = 66;}
 if(byte_read =='4') {PORTC = 99;}
 if(byte_read =='5') {PORTC = 132;}
 if(byte_read =='6') {PORTC = 165;}
 if(byte_read =='7') {PORTC = 180;}
 if(byte_read =='8') {PORTC = 0;}



 }








 }
}
