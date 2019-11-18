#line 1 "E:/Arduino Works 02.02.2017/Home_Auto_All/16F72 softUART and Control Sys/Full System shorter version/New_16F628/MickroC 4Mhz/fourMhzTestproj4VBoard.c"
char uart_rd;




int i =0;
int dim = 128;
int ZC = 0;

int CompMatch =0;
int CompDone =0;

int dimming = 100;

int DimFlag =0;
int DimCounter=0;
int DimTime = 0;

int isButtonPressed1 =0;
int isButtonPressed2 =0;
int isButtonPressed3 =0;
int isButtonPressed4 =0;
int isButtonPressed5 =0;
int isButtonPressed6 =0;

int isButtonOn = 0;
int isButtonOn2 = 0;
int isButtonOn3 = 0;
int isButtonOn4 = 0;


void interrupt(){
 if (INTCON.INTF){
 ZC = 1;
 i=0;

 INTCON.INTF = 0;
 dimCounter=0;
 }
 if(PIR1.CCP1IF) {

 PIR1.CCP1IF =0;
 PIR1.TMR1IF =0;
 CompMatch = 1;
 TMR1L=0;
 TMR1H=0;
 }
}


void InitMain() {
 PORTA=0;
 TRISA=0x00;
 TRISA.RB0=1;
 TRISA.RB1=1;
 TRISA.RB2=0;
 TRISA.RB3=0;
 TRISA.RB4=0;
 TRISA.RA5=0;


 TRISB=0x03;
 TRISB.RB3=0;
 TRISB.RB4=1;
 TRISB.RB5=1;
 TRISB.RB6=1;
 TRISB.RB7=1;
 PORTB=0;



 OPTION_REG.INTEDG = 1;
 INTCON.INTF = 0;
 INTCON.INTE = 1;
 INTCON.GIE = 1;
 INTCON.PEIE = 1;




 TMR1L =0;
 TMR1H=0;

 T1CON.T1CKPS1 = 0;
 T1CON.T1CKPS0 = 0;


 T1CON.TMR1CS =0;
 T1CON.TMR1ON=1;

 PIE1.TMR1IE = 1;







 CCP1CON.CCP1M3 = 1;
 CCP1CON.CCP1M2 = 0;
 CCP1CON.CCP1M1 = 1;
 CCP1CON.CCP1M0 = 0;
 PIE1.CCP1IE =1;


 CCPR1L =0x4B;
 CCPR1H =0x00;




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


 if (uart_rd == 'A') { PORTA.RB3 = 1;}
 if (uart_rd == 'B') { PORTA.RB3 = 0;}
 if (uart_rd == 'C') { PORTA.RB4 = 1;}
 if (uart_rd == 'D') { PORTA.RB4 = 0;}
 if (uart_rd == 'E') { PORTB.RB3 = 1;}
 if (uart_rd == 'F') { PORTB.RB3 = 0;}

 if(uart_rd =='1'){Dimtime = 10;}
 if(uart_rd =='2'){Dimtime = 22;}
 if(uart_rd =='3'){Dimtime = 33;}
 if(uart_rd =='4'){Dimtime = 66;}
 if(uart_rd =='5'){Dimtime = 88;}
 if(uart_rd =='6'){Dimtime = 120;}
 if(uart_rd =='7'){Dimtime = 150;}
 if(uart_rd =='8'){Dimtime = 0;}
 uart_rd = 0;


 if(CompMatch == 1) {
 CompMatch=0;
 if (ZC==1){
 if(DimTime == 1) {
 RA2_bit =1;
 }
 if(Dimtime == 0) {
 RA2_bit = 0;
 } else {
 if(i>=DimTime) {
 RA2_bit = 1;
 }
 if(i>(DimTime+4)) {
 i=0;
 ZC=0;
 RA2_bit =0;
 }
 else {
 i++;
 }
 }
 }
 }
#line 269 "E:/Arduino Works 02.02.2017/Home_Auto_All/16F72 softUART and Control Sys/Full System shorter version/New_16F628/MickroC 4Mhz/fourMhzTestproj4VBoard.c"
}
}
