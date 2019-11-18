#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <EEPROM.h>

const char* ssid = "Your Router's Wifi Name";
const char* password = "Your Router Wifi Password";

const char *ssidAP = "ESPapStationTest222";
const char *passwordAP = "";

ESP8266WebServer server(80);

const int led = 13;

/*
EEPROM.begin(512);
String NetNamePass = "BMPTW03 :+: IN2TH3W1LD@03";
 char NetNamePassChar[(NetNamePass.length()+1)];
 NetNamePass.toCharArray(NetNamePassChar,(NetNamePass.length()+1));
 for(int i = 0; i < (strlen(NetNamePassChar)); i++){
    
      EEPROM.write(i, NetNamePassChar[i]);
    
  }
*/

String AutoIPreturn(){
  if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    return ipaddress;
  }else{
    String ipaddress = WiFi.localIP().toString();
    return ipaddress;
    }
}

String prepareHtmlPage(String IPaddressVer)
{
  String htmlPage = 
     String( "<!DOCTYPE html>")+
                      "<html>"+
                      "<head><title>ESP8266</title>"+
                      "<style>"+
                      
                             ".btn {"+
                              "-webkit-border-radius: 30;"+
                              "-moz-border-radius: 30;"+
                              "border-radius: 30px;"+
                              "font-family: Arial;"+
                              "color: #ffffff;"+
                              "font-size: 20px;"+
                              //"background: #55dbb5;"+
                              "padding: 10px 80px 10px 80px;"+
                              "text-decoration: none;"+
                            "}"+
                            ".btn:hover {"+
                           //  "background: #fc3c89;"+
                              "text-decoration: none;"+
                            "}"+
                            ".btn_red {background: #55dbb5;}"+
                            ".btn_red:hover {background: #fc3c89;}"+
                            ".btn_dark {background: #a6a6a6;}"+
                            ".btn_dark:hover {background: #6b6769;}"+

                            ".btnF {"+
                                 "-webkit-border-radius: 28;"+
                                 "-moz-border-radius: 28;"+
                                 "border-radius: 28px;"+
                                 "font-family: Arial;"+
                                 "color: #ffffff;"+
                                 "font-size: 20px;"+
                                 "background: #f511b8;"+
                                 "padding: 10px 20px 10px 20px;"+
                                 "text-decoration: none;"+
                               "}"+
                                
                             ".btnF:hover {"+
                                  "background: #3cc9fc;"+
                                  "text-decoration: none;"+
                                "}"+
                                                  
                      "</style>"+
                      "</head>"+
                      "<body style=\"text-align: center;\">"+
                      "<hr>"+
                      "<h1><a class=\"btn btn_red\" href=\"http://"+IPaddressVer+"/1\">GPIO_0 ON</a> |||| "+
                      "<a class=\"btn btn_dark\" href=\"http://"+IPaddressVer+"/2\">GPIO_0 OFF</a></h1>"+
                      "<h1><a class=\"btn btn_red\" href=\"http://"+IPaddressVer+"/3\">GPIO_2 ON</a> |||| "+
                      "<a class=\"btn btn_dark\" href=\"http://"+IPaddressVer+"/4\">GPIO_2 OFF</a></h1>"+
                      "<h1><a class=\"btn btn_red\" href=\"http://"+IPaddressVer+"/5\">Light_3 ON</a> |||| "+
                      "<a class=\"btn btn_dark\" href=\"http://"+IPaddressVer+"/6\">Light_3 OFF</a></h1>"+
                      "<hr>"+
                      "<h1><a class=\"btnF\" href=\"http://"+IPaddressVer+"/F1\">Fan ON </a> "+
                      "<a class=\"btnF\" href=\"http://"+IPaddressVer+"/F2\"> 6 </a> "+
                      "<a class=\"btnF\" href=\"http://"+IPaddressVer+"/F3\"> 5 </a> "+
                      "<a class=\"btnF\" href=\"http://"+IPaddressVer+"/F4\"> 4 </a> "+
                      "<a class=\"btnF\" href=\"http://"+IPaddressVer+"/F5\"> 3 </a> "+
                      "<a class=\"btnF\" href=\"http://"+IPaddressVer+"/F6\"> 2 </a> "+
                      "<a class=\"btnF\" href=\"http://"+IPaddressVer+"/F7\"> 1 </a> "+
                      "<a class=\"btnF\" href=\"http://"+IPaddressVer+"/F8\"> Fan OFF</a></h1>"+
                      "<hr>"+
                      "<h1><a class=\"btn btn_red\" href=\"http://"+IPaddressVer+"/testRun\">GPIO_0 ON</a>"+
                      "<hr>"+
                      "<p><a href=\"http://"+IPaddressVer+"/set\">(Settings)</a> || <a href=\"http://"+IPaddressVer+"/config\">(Device Config.)</a></p>"+
                      "<hr>"+
                      "<h1>Msg from esp8266</h1>"+
                      "<p>Control your devices</p>"+
                      "<hr>"+
                      "<h1><P>Local IP:"+WiFi.softAPIP().toString()+"</P></h1>"+
                      "<h1><p>Wifi IP:"+WiFi.localIP().toString()+"</p></h1>"+
                      "<hr>"+
                      "</body>"+
                      "</html>";
  return htmlPage;
}

String prepareHtmlSettingsPage(String IPaddressVer)
{
  String htmlPageOut = "<!DOCTYPE html>";
     htmlPageOut+=      "<html>";
     htmlPageOut+=                "<head><title>ESP8266</title></head>";
     htmlPageOut+=                "<body>";
     htmlPageOut+=                "<hr>";
     htmlPageOut+=                "<form action=\"/action_page.php\" method=\"post\">";
     htmlPageOut+=                   "<fieldset>";
     htmlPageOut+=                     "<legend>Connect to a Router:</legend>";
     htmlPageOut+=                       "Wifi Network Name:<br>";
                                          String temp;
                                          int n = WiFi.scanNetworks(); // number of wifi found 
                                          if (n == 0)
                                                htmlPageOut+= "<p>no networks found</p>";
                                              else
                                              {
                                                //Serial.print(n);
                                                // Serial.println(" networks found");
                                               // htmlPageOut+= "<p>Total Number of network found: "+String(n)+"</p>";
                                                  htmlPageOut+= "<select name=\"networkname\">";
                                                  //htmlPageOut+= "<datalist id=\"wifilists\">";
                                                for (int i = 0; i < n; ++i)
                                                {
                                                   htmlPageOut+= "<option value=\"";
                                                  // Print SSID and RSSI for each network found
                                                  temp = WiFi.SSID(i);
                                                  htmlPageOut+= temp;
                                                  htmlPageOut+= "\">";
                                                  htmlPageOut+= String(i + 1);
                                                  htmlPageOut+= ": ";
                                                  htmlPageOut+= temp;
                                                  htmlPageOut+= " (";
                                                  htmlPageOut+= WiFi.RSSI(i);
                                                  htmlPageOut+= ")";
                                                  htmlPageOut+= ((WiFi.encryptionType(i) == ENC_TYPE_NONE)?" ":"*");
                                                  htmlPageOut+= "</option>";
                                                  delay(10);
                                                }
                                                htmlPageOut+= "</select>";
                                              } 
    
     htmlPageOut+=                           "<br>";
     htmlPageOut+=                           "Password:<br>";
     htmlPageOut+=                         "<input type=\"text\" name=\"networkpass\" value=\"\">";
     htmlPageOut+=                       "<br><br>";
     htmlPageOut+=                     "<input type=\"submit\" value=\"Submit\">";
     htmlPageOut+=                   "</fieldset>";
     htmlPageOut+=                  "</form>";
     htmlPageOut+=                 "<hr>";

       htmlPageOut+=               "<p><a href=\"http://"+AutoIPreturn()+"/\">(Back)</a></p>";
       htmlPageOut+=               "</body>";
       htmlPageOut+=               "</html>";
  return htmlPageOut;
}

String prepareHtmlConfigPage(String IPaddressVer)
{
                const int eeprom_size = 500; // values saved in eeprom should never exceed 500 bytes
              char eeprom_buffer[eeprom_size]; 
              
              for(int i = 0; i < (eeprom_size - 1); i++){
              
                eeprom_buffer[i] = EEPROM.read(i);
              
              }
              String eepromName;
              String eepromPass;
            
              for (int i =0; i<(eeprom_size - 1);i++){
                  if(eeprom_buffer[i] == ':') {
                    if(eeprom_buffer[i+1] == '+') {
                      if(eeprom_buffer[i+2] == ':') {
                        for(int j=0; j<(i-1); j++) {
                          eepromName  += eeprom_buffer[j];
                        } 
                        for(int k=(i+4); k<(500); k++) {
                          if(eeprom_buffer[k] == '\0'){
                            break;
                          }
                          eepromPass += eeprom_buffer[k];
                          
                        }
                      }
                  }
                } 
              }
  
  String htmlPageConfig = 
     String( "<!DOCTYPE html>")+
                      "<html>"+
                      "<head><title>ESP8266</title></head>"+
                      "<body>"+
                      "<p>Device Security Settings</P>"+
                      "<p>User Name: <input type=\"text\" name=\"username\"></p>"+
                      "<p>Password: <input type=\"text\" name=\"userpsw\"></p>"+
                      "<hr>"+
                      "<p>Device Wifi Settings</p>"+
                      "<p>Station Name:</p>"+
                      "<p>User Name:</p>"+
                      "<p>Password:</p>"+
                      "<hr>"+ 
       
              "<P>"+eepromName+"::"+eepromPass+"</P>"+
                      "<hr>"+
                      "<p><a href=\"http://"+IPaddressVer+"/\">(Back)</a></p>"+
                      "</body>"+
                      "</html>";
  return htmlPageConfig;
}

/////////////////////////// Light_1 Start /////////////////////
void GPIO2_on() {
  digitalWrite(led, 1);
  digitalWrite(2, HIGH); // led on by turning low on led pin
  Serial.write('A');

  if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else {
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }
  
  digitalWrite(led, 0);
}

void GPIO2_off() {
  digitalWrite(led, 1);
  digitalWrite(2, LOW); // led off by turning high on pin 
  Serial.write('B');
  
  if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}
/////////////////////////// Light_1 End ///////////////////////

/////////////////////////// Light_2 Start /////////////////////
void GPIO0_on() {
  digitalWrite(led, 1);
  digitalWrite(0, HIGH); // led on by turning low on led pin
  Serial.write('C');
  
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}

void GPIO0_off() {
  digitalWrite(led, 1);
    digitalWrite(0, LOW);
    Serial.write('D');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}
/////////////////////////// Light_2 End ///////////////////////

/////////////////////////// Light_3 Start /////////////////////
void Light_3_on() {
  digitalWrite(led, 1);
   // digitalWrite(0, LOW);
    Serial.write('E');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}

void Light_3_off() {
  digitalWrite(led, 1);
    //digitalWrite(0, LOW);
    Serial.write('F');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}
/////////////////////////// Light_3 End /////////////////////

/////////////////////// Fan_Control Start /////////////////////

////// Fan_on //////
void Fan_on() {
  digitalWrite(led, 1);
    //digitalWrite(0, LOW);
    Serial.write('1');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}

////// Fan_Spd_2 //////
void Fan_Spd_2() {
  digitalWrite(led, 1);
    //digitalWrite(0, LOW);
    Serial.write('2');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}

////// Fan_Spd_3 //////
void Fan_Spd_3() {
  digitalWrite(led, 1);
    //digitalWrite(0, LOW);
    Serial.write('3');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}

////// Fan_Spd_4 //////
void Fan_Spd_4() {
  digitalWrite(led, 1);
    //digitalWrite(0, LOW);
    Serial.write('4');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}

////// Fan_Spd_5 //////
void Fan_Spd_5() {
  digitalWrite(led, 1);
    //digitalWrite(0, LOW);
    Serial.write('5');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}

////// Fan_Spd_6 //////
void Fan_Spd_6() {
  digitalWrite(led, 1);
    //digitalWrite(0, LOW);
    Serial.write('6');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}

////// Fan_Spd_7 //////
void Fan_Spd_7() {
  digitalWrite(led, 1);
    //digitalWrite(0, LOW);
    Serial.write('7');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}

////// Fan_off //////
void Fan_off() {
  digitalWrite(led, 1);
    //digitalWrite(0, LOW);
    Serial.write('8');
    
    if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    }
    
  digitalWrite(led, 0);
}
//////////////////////// Fan_Control End //////////////////////

void SettingsF() {
  digitalWrite(led, 1);

  if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
  server.send(200, "text/html", prepareHtmlSettingsPage(ipaddress) );
  }else {
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlSettingsPage(ipaddress) );
  }
  
  digitalWrite(led, 0);
  }
  
void ConfigF() {
  digitalWrite(led, 1);

  if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    server.send(200, "text/html", prepareHtmlConfigPage(ipaddress) );
  }else{
    String ipaddress = WiFi.localIP().toString();
    server.send(200, "text/html", prepareHtmlConfigPage(ipaddress) );
    }
  digitalWrite(led, 0);
  }

void networkSetupPage() {
  
  String ipaddress = WiFi.softAPIP().toString();
  
  digitalWrite(led, 1);
  String message = "File Found\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET)?"GET":"POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  String NetName;
  String  NetPass;
  uint8_t i =0; 
  NetName = server.arg(i);
  i = i+1;
  NetPass = server.arg(i);
  message += ""+NetName+ ":" + NetPass + "";
  String NetNamePass = ""+NetName+" :+: "+NetPass+"";
  message += "<p><a href=\"http://"+AutoIPreturn()+"/\">(Back)</a></p>";
  
 /*
  String str = NetName; 

    // Length (with one extra character for the null terminator)
    int str_len = str.length() + 1; 
    
    // Prepare the character array (the buffer) 
    char char_array[str_len];
    
    // Copy it over 
    str.toCharArray(char_array, str_len); // here char_array is the converted string2char
  */
 // char NetNameChar = char_array;
 // char NetPassChar[] = "NetPass";
  
  const int eeprom_size = 500; // values saved in eeprom should never exceed 500 bytes
  
  char eeprom_buffer[eeprom_size]; 

    //EEPROM.commit();
  //int i=0;
  /*
  for ( int i =0; i<512; i++) {
    EEPROM.write(i,0);
  }
  */
  //EEPROM.end();
 // EEPROM.commit();
 /*
  char NetNameChar[(NetName.length()+1)];
  NetName.toCharArray(NetNameChar,(NetName.length()+1));
  
  for(int i = 0; i < (strlen(NetNameChar)); i++){
    
      EEPROM.write(i, NetNameChar[i]);
    
  }

 // delay(1000);

  char NetPassChar[(NetPass.length()+1)];
  NetPass.toCharArray(NetPassChar,(NetPass.length()+1));

  //for(int i = 40, j=0; i <(40+(strlen(NetPassChar))), j<(strlen(NetPassChar)); i++, j++){
  for(int i=0; i <(strlen(NetPassChar)); i++){  
      EEPROM.write(i, NetPassChar[i]);
    
  }
*/
 // EEPROM.begin(512);
  
  for ( int i =0; i<512; i++) {
    EEPROM.write(i,0);
  }
 
 char NetNamePassChar[(NetNamePass.length()+1)];
 NetNamePass.toCharArray(NetNamePassChar,(NetNamePass.length()+1));
 for(int i = 0; i < (strlen(NetNamePassChar)); i++){
    
      EEPROM.write(i, NetNamePassChar[i]);
    
  }

 

  

  for(int i = 0; i < (eeprom_size - 1); i++){
  
    eeprom_buffer[i] = EEPROM.read(i);
  
  }
  String eepromName;
  String eepromPass;

  for (int i =0; i<(eeprom_size - 1);i++){
      if(eeprom_buffer[i] == ':') {
        if(eeprom_buffer[i+1] == '+') {
          if(eeprom_buffer[i+2] == ':') {
            for(int j=0; j<(i-1); j++) {
              eepromName  += eeprom_buffer[j];
            } 
            for(int k=(i+4); k<(500); k++) {
              if(eeprom_buffer[k] == '\0'){
                break;
              }
              eepromPass += eeprom_buffer[k];
              
            }
          }
      }
    }
  }
  
  
  message += eeprom_buffer;
  message += "<p>"+eepromName+":"+eepromPass+"</p>";
  message +="<p><a href=\"http://"+AutoIPreturn()+"/SubmitNP\">(Submit)</a></p>";
 // message +=eepromName;
//  message += eepromPass;
  
 /*
  char tempN[30];
  char tempP[30]; 
  for (uint8_t i=0; i<server.args(); i++){
    tempN[i] = string.toCharArray(server.argName(i));
    tempP[i] = string.toCharArray(server.arg(i));
    message += " " + tempN[i] + ": " + tempP[i] + "\n";
  } */
  server.send(404, "text/html", message);
 // server.send(200, "text/html", "<p><a href=\"http://"+(WiFi.localIP().toString())+"/\">(Back)</a></p>");
 // Serial.print(message);
  digitalWrite(led, 0);
}

// Router Connection setup Start
void NPreLoadPage() {
 // EEPROM.begin(512);
  
              // read username pass from eeprom
            
              const int eeprom_size = 500; // values saved in eeprom should never exceed 500 bytes
              char eeprom_buffer[eeprom_size]; 
              
              for(int i = 0; i < (eeprom_size - 1); i++){
              
                eeprom_buffer[i] = EEPROM.read(i);
              
              }
              String eepromName;
              String eepromPass;
            
              for (int i =0; i<(eeprom_size - 1);i++){
                  if(eeprom_buffer[i] == ':') {
                    if(eeprom_buffer[i+1] == '+') {
                      if(eeprom_buffer[i+2] == ':') {
                        for(int j=0; j<(i-1); j++) {
                          eepromName  += eeprom_buffer[j];
                        } 
                        for(int k=(i+4); k<(500); k++) {
                          if(eeprom_buffer[k] == '\0'){
                            break;
                          }
                          eepromPass += eeprom_buffer[k];
                          
                        }
                      }
                  }
                }
              }
            
            
            //end loading UN Pass from eeeprom

            

            server.send(200, "text/html", "<p><a href=\"http://"+(WiFi.softAPIP().toString())+"/\">(Back)</a><P>"+eepromName+"::"+eepromPass+"</P></p><p>Wait 10 Seconds and then click on <b>(Back)</b> Button</p>");
            //server.send(200, "text/plain", "<p><a href=\"http://"+(WiFi.softAPIP().toString())+"/\">(gffsdsd)</a></p>");

              if (WiFi.status() != WL_CONNECTED) {
                  WiFi.begin(eepromName.c_str(), eepromPass.c_str());
                 }else{
                  WiFi.disconnect();
                  WiFi.begin(eepromName.c_str(), eepromPass.c_str());
                  }
    
                  int f = 0;
                  while (WiFi.status() != WL_CONNECTED) {
                     f++;
                    delay(500);
                     if (f == 20) {
                     break;
                    }
                  }

            
              /*
               * </p><P>"+eepromName+"::"+eepromPass+"</P>
               */ 
             //  char* wifiNameWW = eepromName;
             //  char* wifiPassWW = eepromPass;
        /*
             if (WiFi.status() != WL_CONNECTED) {
              WiFi.begin(eepromName.c_str(), eepromPass.c_str());
             }else{
              WiFi.disconnect();
              WiFi.begin(eepromName.c_str(), eepromPass.c_str());
              }
              */
            //  WiFi.begin(eepromName.c_str(), eepromPass.c_str());
             // Serial.println("");

             /*
              // Wait for connection
              int f = 0;
              while (WiFi.status() != WL_CONNECTED) {
                 f++
                delay(500);
                 if (f == 20) {
                 break;
                }
              }

              */
              
             server.send(200, "text/html", "<p><a href=\"http://"+(WiFi.localIP().toString())+"/\">(Back)</a></p>");
             
  
}
// Router Connection setup end

void String2CharReturn (String str) {
      
     //String str = NetName; 

    // Length (with one extra character for the null terminator)
    int str_len = str.length() + 1; 
    
    // Prepare the character array (the buffer) 
    char char_array[str_len];
    
    // Copy it over 
    str.toCharArray(char_array, str_len); // here char_array is the converted string2char

  }

  
// eeprom read/write function 
void save_string_to_eeprom(char* stringIn){
  
  for(int i = 0; i < (strlen(stringIn) - 1); i++){
    
      EEPROM.write(i, stringIn[i]);
    
  }

}


void read_string_from_eeprom(char* theBuffer){
  
  for(int i = 0; i < (strlen(theBuffer) - 1); i++){
  
    theBuffer[i] = EEPROM.read(i);
  
  }

}
//eeprom read/write function end

void testRunF() {
  digitalWrite(led, 1);
  digitalWrite(2, HIGH); // led on by turning low on led pin
  String ipaddress = WiFi.localIP().toString();
  if(WiFi.status() != WL_CONNECTED) {
    server.send(200, "text/html", "This is not connected " );
  }
  else {
    server.send(200, "text/html", "This is connected" );
  }
  digitalWrite(led, 0);
}
  
void handleRoot() {  

  //String ipaddress = WiFi.localIP().toString();
  // String ipaddress = WiFi.softAPIP().toString();
  if(WiFi.status() != WL_CONNECTED) {
    String ipaddress = WiFi.softAPIP().toString();
    digitalWrite(led, 1);
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    digitalWrite(led, 0);
  }else{
    String ipaddress = WiFi.localIP().toString();
    digitalWrite(led, 1);
    server.send(200, "text/html", prepareHtmlPage(ipaddress) );
    digitalWrite(led, 0);
    }
    
    //String ipaddress = WiFi.softAPIP().toString();
   // server.send(200, "text/html", prepareHtmlPage(ipaddress) );
 // digitalWrite(led, 1);
   //server.send(200, "text/html", prepareHtmlPage(ipaddress) );
  //server.send(200, "text/plain", "hello from esp8266!");
  //server.send(200, "text/plain",ipaddress);
 // digitalWrite(led, 0);
}

void handleNotFound(){
  digitalWrite(led, 1);
  String message = "File Not Found\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET)?"GET":"POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  for (uint8_t i=0; i<server.args(); i++){
    message += " " + server.argName(i) + ": " + server.arg(i) + "\n";
  }
  server.send(404, "text/plain", message);
  Serial.print(message);
  digitalWrite(led, 0);
}


void setup(void){
  Serial.begin(9600);
  EEPROM.begin(512);
  WiFi.disconnect();
  

  pinMode(2, OUTPUT); //eidted by me
  pinMode(0, OUTPUT); //edited
  
  pinMode(led, OUTPUT);
  digitalWrite(led, 0);
  Serial.begin(9600);

  /*
  //WiFi.begin(ssid, password);
  WiFi.begin(ssid, password);
  Serial.println("");

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
 
*/

 // Star APmode setup
  WiFi.softAP(ssidAP, passwordAP);

  IPAddress myIP = WiFi.softAPIP();

 // End APmode setup
  if (MDNS.begin("esp8266")) {
    Serial.println("MDNS responder started");
  }
  

  server.on("/", handleRoot);

  server.on("/1", GPIO2_on); // edited by me. if one is gotten on the server then turn the led on
  server.on("/2", GPIO2_off); // if 2 is put on the server then turn the led off
  server.on("/3", GPIO0_on);
  server.on("/4", GPIO0_off);
  server.on("/5", Light_3_on);
  server.on("/6", Light_3_off);
  
  server.on("/F1", Fan_on);
  server.on("/F2", Fan_Spd_2);
  server.on("/F3", Fan_Spd_3);
  server.on("/F4", Fan_Spd_4);
  server.on("/F5", Fan_Spd_5);
  server.on("/F6", Fan_Spd_6);
  server.on("/F7", Fan_Spd_7);
  server.on("/F8", Fan_off);
  
  server.on("/set", SettingsF);
  server.on("/config", ConfigF);
  server.on("/action_page.php", networkSetupPage);
  server.on("/SubmitNP", NPreLoadPage);
  server.on("/testRun", testRunF);

  server.on("/inline", [](){
    server.send(200, "text/plain", "this works as well");
  });
  

  server.onNotFound(handleNotFound);

  server.begin();
  Serial.println("HTTP server started");
}


void loop(void){
  server.handleClient();
}

