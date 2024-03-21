#include <stdint.h>

uint8_t a = 25;
int8_t b = -2;
uint8_t c = -10;
uint16_t d = 40000;
uint16_t e = 40000;
int32_t x = 3400;
int32_t y = 2800;
uint32_t f;
uint16_t g, h;
uint32_t i;
int32_t j;
int32_t z;

int main()
{
  f = a + 190;   // 215
  g = b - 12;    // -14
  h = c + 15;    // 261
  i = d - 45000; // 4294962296
  j = e - 45000; // -5000
  z = x + y;     // 6200

  return 0;
}
