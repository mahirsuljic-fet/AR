#include <stdint.h>

// Prevesti sljedeci kod u assembler
// Koju ce decimalnu vrijednost imati varijabla res nakon izvrsenja koda?
//
// Odgovor:
// res = -34

const uint16_t num = 0xC0DE;
int8_t res;

int main()
{
  int t0 = num;
  int t1 = t0 + 0xCAFE0000;
  res = t1;
  return res;
}
