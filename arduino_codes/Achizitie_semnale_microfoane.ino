

 #define FASTADC 1
#ifndef cbi
#define cbi(sfr, bit) (_SFR_BYTE(sfr) &= ~_BV(bit))
#endif
#ifndef sbi
#define sbi(sfr, bit) (_SFR_BYTE(sfr) |= _BV(bit))
#endif
int i=0;
void setup() {
#if FASTADC
  // set prescale to 16
  cbi(ADCSRA, ADPS1) ;
  cbi(ADCSRA, ADPS0) ;
#endif
Serial.begin(115200);
}
void loop() {
  // put your main code here, to run repeatedly:
      float sensorValue1 = analogRead(A0);
      float t1=5.*sensorValue1/1024.;
      float sensorValue2 = analogRead(A1);
      float t2=5.*sensorValue2/1024.;
      float sensorValue3 = analogRead(A2);
      float t3=5.*sensorValue3/1024.;
      float sensorValue4 = analogRead(A3);
      float t4=5.*sensorValue4/1024.;
        //Serial.println("Senzor1");
        Serial.println(t1);
         // Serial.println("Senzor2");
        Serial.println(t2);
         // Serial.println("Senzor3");
        Serial.println(t3);
          //Serial.println("Senzor4");
        Serial.println(t4);
         
}
        
