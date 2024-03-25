int sum(int a0)
{
  int v0 = 0;
  for (int t0 = 1; t0 <= a0; ++t0)
    v0 += t0;

  return v0;
}

static int rez = 0;

int main()
{
  rez = sum(5);

  return 0;
}
