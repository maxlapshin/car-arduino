#include <Servo.h>

Servo wheel;
int i;
int ledPin =  13;    // LED connected to digital pin 13
int radioPin = 3;

void setup() 
{
  Serial.begin(19200);
  //wheel.attach(3, 961, 3542);
  // initialize the digital pin as an output:
  pinMode(ledPin, OUTPUT);
  pinMode(radioPin, INPUT);
  attachInterrupt(radioPin, radioControl, RISING);
  //wheel.writeMicroseconds(2500);
}

void radioControl()
{
  digitalWrite(ledPin, HIGH);
  for(i = 0; i < 3000; i++) {
    if (digitalRead(radioPin) == LOW) {
      digitalWrite(ledPin, LOW);
      break;
    }
    delay(1);
  }
  Serial.println(i);
}

void loop()
{
  digitalWrite(ledPin, HIGH);
  Serial.print("PING");
  Serial.println(digitalRead(radioPin));
  delay(500);
  digitalWrite(ledPin, LOW);
  delay(1500);
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


