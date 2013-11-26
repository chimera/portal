const int LOCK = 13;
const int DELAY = 1000;
const int BAUD = 9600;

void setup() {
  Serial.begin(BAUD);
  pinMode(LOCK, OUTPUT);
}

void loop() {
  while (Serial.available() > 0) {
    if (Serial.parseInt() == 1) {
      unlock();
    }
  }
}

void unlock() {
  digitalWrite(LOCK, HIGH);
  delay(DELAY);
  digitalWrite(LOCK, LOW);
}
