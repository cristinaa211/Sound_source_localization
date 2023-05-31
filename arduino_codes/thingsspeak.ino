
#include "ThingSpeak.h"
#include <ESP8266WiFi.h>
#include <ESP8266WiFiMulti.h>
#ifndef STASSID
#define STASSID "your-ssid"
#define STAPSK  "your-password"
#endif

const char* ssid     = "";
const char* password = "";

const char* host = "";
const uint16_t port = ;
int keyIndex = 0;            
unsigned long myChannelNumber = 1006711;
const char * myWriteAPIKey = "LTV5JU2628LSSSJP";
ESP8266WiFiMulti WiFiMulti;
WiFiClient  client;
int number = 0;
void setup() {
  Serial.begin(9600);
  
  // We start by connecting to a WiFi network
  WiFi.mode(WIFI_STA);
  WiFiMulti.addAP(ssid, password);
  ThingSpeak.begin(client);  // Initialize ThingSpeak
  Serial.println();
  Serial.println();
  Serial.print("Wait for WiFi... ");

  while (WiFiMulti.run() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  delay(500);
 WiFiClient client;

  if (!client.connect(host, port)) {
    Serial.println("connection failed");
    Serial.println("wait 5 sec...");
    delay(10);
    return;
  }

  // This will send the request to the server
  client.println("hello from ESP8266");
  Serial.print("connecting to ");
  Serial.print(host);
  Serial.print(':');
  Serial.println(port);
  //read back one line from server
  Serial.println("receiving from remote server");
  String line = client.readStringUntil('\r');
  Serial.println(line);

  Serial.println("closing connection");
  client.stop();

  Serial.println("wait 5 sec...");
  delay(5000);
}
void loop() {

   float sensorValue1 = analogRead(A0);
   float t1=5.*sensorValue1/1024.;
   Serial.println(t1);
   float x = ThingSpeak.writeField(myChannelNumber, 1, t1, myWriteAPIKey);
  

}
