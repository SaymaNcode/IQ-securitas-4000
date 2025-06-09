const int sensor1Pin = 2;  // Dvere 1
const int sensor2Pin = 3;  // Dvere 2
const int pirPin     = 4;  // PIR senzor
const int buzzerPin  = 5;  // Bzučiak
bool alarmEnabled = true; // Stav alarmu

void setup() {
  Serial.begin(9600);
  pinMode(sensor1Pin, INPUT_PULLUP);
  pinMode(sensor2Pin, INPUT_PULLUP);
  pinMode(pirPin, INPUT);
  pinMode(buzzerPin, OUTPUT);
}

void loop() {

  bool door1Open = digitalRead(sensor1Pin) == HIGH;
  bool door2Open = digitalRead(sensor2Pin) == HIGH;
  bool motionDetected = digitalRead(pirPin) == HIGH;

  if (alarmEnabled && (door1Open || door2Open || motionDetected)) {
    digitalWrite(buzzerPin, HIGH);
    Serial.println("ALARM!");
    delay(500);
    digitalWrite(buzzerPin, LOW);
  } else {
    digitalWrite(buzzerPin, LOW);
  }

  // Logovanie stavu senzorov
  Serial.print("Door1:");
  Serial.print(door1Open);
  Serial.print("|Door2:");
  Serial.print(door2Open);
  Serial.print("|PIR:");
  Serial.println(motionDetected);
  
  delay(1000);
}