#include <Servo.h>

Servo wheel;
int i;
int ledPin =  13;    // LED connected to digital pin 13
int radioPin = 3;
unsigned long radioStartTime = 0;
int radioPulseWidth = 0;

unsigned long wheelStartTime = 0;
int wheelPulseWidth = 0;


void setup() 
{
  Serial.begin(19200);
  //wheel.attach(3, 961, 3542);
  // initialize the digital pin as an output:
  pinMode(ledPin, OUTPUT);
  pinMode(3, INPUT);
  pinMode(2, INPUT);
  attachInterrupt(1, radioMeasure, CHANGE);
  attachInterrupt(0, wheelMeasure, CHANGE);
  //wheel.writeMicroseconds(2500);
}

void radioMeasure()
{
  if (radioStartTime) {
    radioPulseWidth = micros() - radioStartTime;
    digitalWrite(ledPin, LOW);
    radioStartTime = 0;
  } else {
    digitalWrite(ledPin, HIGH);
    radioStartTime = micros();
    radioPulseWidth = 0;
  }
}

void wheelMeasure()
{
  if (wheelStartTime) {
    wheelPulseWidth = micros() - wheelStartTime;
    wheelStartTime = 0;
  } else {
    wheelStartTime = micros();
    wheelPulseWidth = 0;
  }
}



void loop()
{
  //digitalWrite(ledPin, HIGH);
  Serial.print(radioPulseWidth);
  Serial.print(" ");
  Serial.println(wheelPulseWidth);
  delay(100);
}

void rotate(int from, int to, int step_) 
{
   for(i = 80; i >= 0; i-= 10) {
   digitalWrite(ledPin, HIGH);
   wheel.write(i);
   delay(50);
   digitalWrite(ledPin, LOW);
   delay(50);
 }
 delay(500);
}

void loop1() 
{
  /*
 rotate(90, 0, -10);
 rotate(0, 180, 10);
 rotate(180, 90, -10);
*/
 for(i = 1540; i > 650; i-=3) {
   wheel.writeMicroseconds(i);
   delay(1);
 }
 
 digitalWrite(ledPin, HIGH);
 for(i = 650; i > 2500; i++) {
   wheel.writeMicroseconds(i);
   delay(1);
 }
 digitalWrite(ledPin, LOW);

 for(i = 2500; i >= 1540; i-=3) {
   wheel.writeMicroseconds(i);
   delay(1);
 }

 delay(1000);
}


