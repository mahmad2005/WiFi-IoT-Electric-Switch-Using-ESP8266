char uart_rd;
char *uart_rd_temp[20];
char uart_string[20];
int SPD = 0;

unsigned char FlagReg;
sbit ZC at FlagReg.B0;
int shadow_PORTA =0;
int shadow_PORTB =0;

//volatile int i =0;
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
     if (INTCON.INTF){          //INTF flag raised, so external interrupt occured
        ZC = 1;
        i=0;
        //PORTC.RC5 = 0;
        INTCON.INTF = 0;
        dimCounter=0;
     }
     if(PIR1.CCP1IF) {
        // PORTC.RC6 ^=1;
         PIR1.CCP1IF =0;
         PIR1.TMR1IF =0;
         CompMatch = 1;
         TMR1L=0;
         TMR1H=0;
     }
}
   // */

void InitMain() {
 PORTA=0;
 TRISA=0x00;
 TRISA.RA0=1;
 TRISA.RA1=1;
 TRISA.RA2=0;
 TRISA.RA3=0;
 TRISA.RA4=0;
 TRISA.RA5=0;
 //TRISA.RA6=0;
 //TRISA.RA7=0;
 TRISB=0x03;  // rx pin musb be set input. otherwise it will not work
 TRISB.RB3=0;
 TRISB.RB4=1;
 TRISB.RB5=1;
 TRISB.RB6=1;
 TRISB.RB7=1;
 PORTB=0;
 //PORTA.RA4=1; // RA4 has some problemss . it needs a pull up resistor to work properly
 

 OPTION_REG.INTEDG = 1;      //interrupt on falling edge
     INTCON.INTF = 0;           //clear interrupt flag
     INTCON.INTE = 1;           //enable external interrupt
     INTCON.GIE = 1;            //enable global interrupt
     INTCON.PEIE = 1; // enable periferal interrupt



//timer setup
     TMR1L =0;
     TMR1H=0;

     T1CON.T1CKPS1 = 0;
     T1CON.T1CKPS0 = 0;
     //  T1CON.T1OSCEN = 1; //oscilator select bit.
     //T1CON2|=1; // dont syncronize external clock input
     T1CON.TMR1CS =0; // timer1 Source clock. 0 = internal, 1 = external
     T1CON.TMR1ON=1;    //timer on bit

     PIE1.TMR1IE = 1; // timer overflow enable
    // PIE1.RCIE = 1;
    // PIE1.TXIE = 1;

//end timer setup

//compare mode system
       //CCP1CON:CCP1M3:CCP1M0_bit=1010;  // compare mode, generated software interrup on match
       CCP1CON.CCP1M3 = 1;
       CCP1CON.CCP1M2 = 0;
       CCP1CON.CCP1M1 = 1;
       CCP1CON.CCP1M0 = 0;
      PIE1.CCP1IE =1;  // CCP1 interrupt enable bit

      // CCPR1 resister who's value will be constantly checked with timer1 value
      CCPR1L =0x4B;
      CCPR1H =0x00;
//compare mode end



  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize
  
  UART1_Write_Text("Start");
  UART1_Write(10);
  UART1_Write(13);


}

void main() {
InitMain();
while(1) {
  //UART1_Write_Text("Start");

 //PORTB.RA7=0;
    if (UART1_Data_Ready()) {     // If data is received,
      UART1_Read_Text(uart_string,"OK",20);     // read the received data,     // eita akta loop er moto kore kaj kore. so jokhon data
                                                // ready hobe and until "OK" powa jabe nah. eita akhane choltei thakbe 
                                                //. problem! but khub boro problem nah.
      UART1_Write_Text(uart_string);
      uart_rd = uart_string[0];
      //uart_rd_temp = uart_string;
      //UART1_Write(uart_rd_temp[0]);
    }
    

    if (uart_rd == 'A') { shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA; }  //PORTA.RA3 =1;  // bitwise OR kora hoyese..
    if (uart_rd == 'B') { shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA3 = 0;  firste bitwise AND kore then bitsie XOR kora hoyuese.
    if (uart_rd == 'C') { shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;} //PORTA.RA4 = 1
    if (uart_rd == 'D') { shadow_PORTA = ((shadow_PORTA & 16) ^ shadow_PORTA); PORTA = shadow_PORTA;} //PORTA.RA4 = 0
    //if (uart_rd == 'E') { PORTB.RB3 = 1;}
    //if (uart_rd == 'F') { PORTB.RB3 = 0;}
    if (uart_rd == 'E') { shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;}  //PORTA.RA2 =1
    if (uart_rd == 'F') { shadow_PORTA = ((shadow_PORTA & 4) ^ shadow_PORTA); PORTA = shadow_PORTA;}  //PORTA.RA2 = 0;
    
    if(uart_string[0] == 'S') {
      //uart_rd = uart_string[1];
      SPD = (((uart_string[1] - 48)*10)+(uart_string[2]-48));   // ASCII to decimal Convertion
      Dimtime = SPD;
    /*if(uart_rd =='1'){Dimtime = 10;}
      if(uart_rd =='2'){Dimtime = 22;}
      if(uart_rd =='3'){Dimtime = 33;}
      if(uart_rd =='4'){Dimtime = 66;}
      if(uart_rd =='5'){Dimtime = 88;}
      if(uart_rd =='6'){Dimtime = 120;}
      if(uart_rd =='7'){Dimtime = 150;}
      if(uart_rd =='8'){Dimtime = 0;}*/
    }
    
    uart_rd = 0;
    //welse {DimTime = 33;}

          if(CompMatch == 1) {
             CompMatch=0;
             if (ZC){ //zero crossing occurred
              if(DimTime == 1) {
                     //PORTB.RB3 =1;
                     //shadow_PORTB = shadow_PORTB|8; PORTB = shadow_PORTB; //RB3 on
                     shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA;

              }
              if(Dimtime == 0) {
                     //PORTB.RB3 = 0;
                     //shadow_PORTB = ((shadow_PORTB & 8) ^ shadow_PORTB); PORTB = shadow_PORTB;
                     shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;
              } else {
                         if(i>=DimTime) {
                           //PORTB.RB3 = 1;
                           //shadow_PORTB = shadow_PORTB|8; PORTB = shadow_PORTB;
                           shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA;
                         }
                         if(i>(DimTime+4)) {
                              i=0;
                              ZC=0;
                              //PORTB.RB3 =0;
                              //shadow_PORTB = ((shadow_PORTB & 8) ^ shadow_PORTB); PORTB = shadow_PORTB;
                              shadow_PORTA = ((shadow_PORTA & 8) ^ shadow_PORTA); PORTA = shadow_PORTA;
                           }
                         else {
                         i++;
                       }
                 }
             }
           }

           //UART1_Write_Text("Start");

           if(PORTA.RA0 == 1) {
              if(isButtonPressed1 == 0) {
                DimTime = DimTime+10;
                isButtonPressed1 =1;
                //PORTB.RB4=1;
              }
            }else {
                isButtonPressed1=0;
                //PORTB.RB4=0;
            }

            if(RA1_bit) {
              if(isButtonPressed2 == 0) {
                DimTime = DimTime-10;
                isButtonPressed2 =1;
               // PORTB.RB5=1;
              }
            }else {
                isButtonPressed2=0;
              //  PORTB.RB5=0;
            }
            
            if(RB7_bit) {
              if(isButtonPressed3 == 0) {
                isButtonPressed3 =1;
                if(isButtonOn ==0) {
                isButtonOn = 1;
                //PORTA.RA3 = 0;
                shadow_PORTA = shadow_PORTA|8; PORTA = shadow_PORTA;
                //Dimtime = 0;
                }
                else {
                isButtonOn = 0;
                //PORTA.RA3 = 0;
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
                //PORTA.RA4 = 1;
                shadow_PORTA = shadow_PORTA|16; PORTA = shadow_PORTA;
                }
                else {
                isButtonOn2 = 0;
                //PORTA.RA4 = 0;
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
                //PORTA.RA5 = 1;
                shadow_PORTA = shadow_PORTA|4; PORTA = shadow_PORTA;
                }
                else {
                isButtonOn3 = 0;
                //PORTA.RA5 = 0;
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
                //PORTA.RA2 = 1;
                Dimtime = 0;
                }
                else {
                isButtonOn4 = 0;
                //PORTA.RA2 = 0;
                Dimtime = 1;
                }

              }
            }else {
                isButtonPressed6=0;
                
            }
               // */
}
}