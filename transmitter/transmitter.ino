#include <LoRa.h>
void setup() {
  Serial.begin(115200);
  LoRa.setPins(18, 14, 26);
  if (!LoRa.begin(915E6)) {
    Serial.println("Erro ao iniciar LoRa");
    while (1);
  }
}

void loop() {
  char buff[32] = { 0 };

  uint16_t data_length = Serial.available();
  if(data_length > 0) {

    Serial.readBytes(buff, data_length);

    Serial.printf("Enviando: ");
    
    LoRa.beginPacket();
    for(uint8_t i = 0; i < data_length; i++) {
      LoRa.print(buff[i]);
      Serial.printf("%c", buff[i]);
    }
    LoRa.endPacket();

    Serial.println("\nEnviado via LoRa!");
  }

  delay(128);
}

