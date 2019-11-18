#line 1 "E:/Arduino Works 02.02.2017/Home_Auto_All/16F72 softUART and Control Sys/Full System shorter version/New_16F628/MikroC/Backup 31.08.2017/HomeAuto_pic16f628.c"
char uart_rd;
char *uart_rd_temp[20];
char uart_string[20];
int SPD = 0;

unsigned char FlagReg;
sbit ZC at FlagReg.B0;
int shadow_PORTA =0;
int shadow_PORTB =0;


int i =0;
int dim = 128;

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
 TRISA.RA0=1;
 TRISA.RA1=1;
 TRISA.RA2=0;
 TRISA.RA3=0;
 TRISA.RA4=0;
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
 UART1_Read_Text(uart_string,"OK",20);


 UART1_Write_Text(uart_string);
 uart_rd = uart_string[0];


 }


 if (uart_rd == 'A') { shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA; }
 if (uart_rd == 'B') { shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;}
 if (uart_rd == 'C') { shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;}
 if (uart_rd == 'D') { shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;}


 if (uart_rd == 'E') { shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;}
 if (uart_rd == 'F') { shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;}

 if(uart_string[0] == 'S') {

 SPD = (((uart_string[1] - 48)*10)+(uart_string[2]-48));
 Dimtime = SPD;
#line 166 "E:/Arduino Works 02.02.2017/Home_Auto_All/16F72 softUART and Control Sys/Full System shorter version/New_16F628/MikroC/Backup 31.08.2017/HomeAuto_pic16f628.c"
 }

 uart_rd = 0;


 if(CompMatch == 1) {
 CompMatch=0;
 if (ZC){
 if(DimTime == 1) {


 shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA;

 }
 if(Dimtime == 0) {


 shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;
 } else {
 if(i>=DimTime) {


 shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA;
 }
 if(i>(DimTime+4)) {
 i=0;
 ZC=0;


 shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;
 }
 else {
 i++;
 }
 }
 }
 }



 if(PORTA.RA0 == 1) {
 if(isButtonPressed1 == 0) {
 DimTime = DimTime+10;
 isButtonPressed1 =1;

 }
 }else {
 isButtonPressed1=0;

 }

 if(RA1_bit) {
 if(isButtonPressed2 == 0) {
 DimTime = DimTime-10;
 isButtonPressed2 =1;

 }
 }else {
 isButtonPressed2=0;

 }

 if(RB7_bit) {
 if(isButtonPressed3 == 0) {
 isButtonPressed3 =1;
 if(isButtonOn ==0) {
 isButtonOn = 1;

 shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA;

 }
 else {
 isButtonOn = 0;

 shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;
 }

 }
 }else {
 isButtonPressed3=0;
 }

 if(RB6_bit) {
 if(isButtonPressed4 == 0) {
 isButtonPressed4 =1;
 if(isButtonOn2 ==0) {
 isButtonOn2 = 1;

 shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;
 }
 else {
 isButtonOn2 = 0;

 shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;
 }

 }
 }else {
 isButtonPressed4=0;
 }

 if(RB5_bit) {
 if(isButtonPressed5 == 0) {
 isButtonPressed5 =1;
 if(isButtonOn3 ==0) {
 isButtonOn3 = 1;

 shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;
 }
 else {
 isButtonOn3 = 0;

 shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;
 }

 }
 }else {
 isButtonPressed5=0;
 }

 if(RB4_bit) {
 if(isButtonPressed6 == 0) {
 isButtonPressed6 =1;
 if(isButtonOn4 ==0) {
 isButtonOn4 = 1;

 Dimtime = 0;
 }
 else {
 isButtonOn4 = 0;

 Dimtime = 1;
 }

 }
 }else {
 isButtonPressed6=0;

 }

}
}
