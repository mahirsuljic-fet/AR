int bar(int x, int y)
{
  return x & y;
}

int foo(int x, int y)
{
  return bar(x, x) + y;
}
