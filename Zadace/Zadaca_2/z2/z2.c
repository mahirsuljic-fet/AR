#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

static void combinations_impl(char* chars, uint32_t maxr, uint32_t size, uint32_t r);
static void print_comb(uint32_t maxr);

static char* d;
void combinations(char* chars, uint32_t size, uint32_t r)
{
  d = (char*)malloc(r);
  combinations_impl(chars, r, size, r);
}

static void combinations_impl(char* chars, uint32_t maxr, uint32_t size, uint32_t r)
{
  if (r == 0)
  {
    print_comb(maxr);
    return;
  }
  for (int i = 0; i < size; ++i)
  {
    d[maxr - r] = chars[i];
    combinations_impl(chars, maxr, size, r - 1);
  }
}

static void print_comb(uint32_t maxr)
{
  for (int i = 0; i < maxr; ++i)
    printf("%c", d[i]);
  printf("\n");
}

int main(int argc, char const* argv[])
{
  char set[] = { 'a', 'b' };
  combinations(set, 2, 2);
  return 0;
}
