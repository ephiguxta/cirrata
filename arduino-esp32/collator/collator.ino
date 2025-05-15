#include "MAX6675.h"

const int max6675_ss = 5;
const int spi_clk = 18;
const int spi_miso = 19;

MAX6675 max6675(max6675_ss, spi_miso, spi_clk);

void setup() {
  Serial.begin(115200);
  
  max6675.begin();
  max6675.setSPIspeed(4e6);
}

void loop() {
  delay(256);

  int status = max6675.read();
  float max6675_temp = max6675.getCelsius();

  Serial.println(max6675_temp);

}
