#include <stdio.h>

static int bar = 5; // nema .globl
char foo;           // bss

int main()
{
  printf("Pozdrav svima"); 
  return 0;
}
