#include <stdint.h>

uint8_t a = 5;
uint8_t b = 7;
int8_t c;

int main()
{
  int t0;

  if (a == b)
    t0 = a;
  else
    t0 = b;

  c = (a + b) * 2;

  return 0;
}
