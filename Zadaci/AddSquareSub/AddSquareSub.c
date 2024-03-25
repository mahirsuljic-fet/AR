int square(int x)
{
  return x * x;
}

int foo(int a, int b, int c)
{
  return a + square(b) - c;
}

int rez;

int main()
{
  rez = foo(1, 2, 3);

  return 0;
}
