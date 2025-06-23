unsigned long counter = 0;

void setup() {
	Serial.begin(115200);
}

void loop() {
	Serial.printf("%d\n", counter);

	counter += 1;

	delay(500);
}
