// Napisati funkciju foo koja uzima dva short-a i vraca uint32_t
// funkcija treba da provjeri da li je drugi argument jednak nuli
// te ukoliko jeste da nazad vrati sve jedinice (32 jedinice)
// u suprotnom u najjacin 16 bita povratne vrijednosti treba da bude rezultat
// dijeljenja dva argumenta, a u najslabijih 16 bita rezultat ostatka dijeljenja

#include <stdint.h>
#include <stdio.h>

uint32_t foo(short a, short b);

int main(int argc, char* argv[])
{
  uint32_t res = foo(10, 3);
  printf("Result: 0x%08x\n", res);
  return 0;
}
