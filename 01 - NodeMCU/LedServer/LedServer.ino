#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>

#define LED1 D5

const char* ssid = "Wifi Name";
const char* password = "Wifi Password";

ESP8266WebServer server(80);

const int led = 13;

void handleRoot() {
  digitalWrite(led, 1);
  server.send(200, "text/plain", "hello from esp8266!");
  digitalWrite(led, 0);
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
  digitalWrite(led, 0);
}

bool isInteger(String inputString)
{
  for (int i = 0; i < inputString.length(); i++){
    if(!isDigit(inputString.charAt(i)))
    {
      return false;
    }
  }
  return true;
}

void handleCommand(){
  digitalWrite(led, 1);
  String message = "Command Triggered.\n\n";

  message += "\n";
  message += "led value: " + server.arg("led");

  if(isInteger(server.arg("led")))
  {
    int iLed = server.arg("led").toInt();
    if(iLed == 1)
    {
      digitalWrite(LED1, HIGH); 
      Serial.println("LED On.");
    }
    else if(iLed == 0)
    {
      digitalWrite(LED1, LOW); 
      Serial.println("LED Off.");
    }
  }
  
  server.send(200, "text/plain", message);
  digitalWrite(led, 0);
}

void setup(void){
  pinMode(led, OUTPUT);
  pinMode(LED1, OUTPUT);
  digitalWrite(led, 0);
  Serial.begin(9600);
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

  if (MDNS.begin("esp8266")) {
    Serial.println("MDNS responder started");
  }

  server.on("/", handleRoot);

  server.on("/inline", [](){
    server.send(200, "text/plain", "this works as well");
  });

  server.on("/cmd", handleCommand);

  server.onNotFound(handleNotFound);

  server.begin();
  Serial.println("HTTP server started");
}

void loop(void){
  server.handleClient();
}
