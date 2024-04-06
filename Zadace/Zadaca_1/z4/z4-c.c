// short size = 5;
// short niz[5] = { 1, 19, 350, 740, 1522 };
short size = 6;
short niz[6] = { 1, 19, 350, 740, 1552, 2020 };
int result = 0;

int main()
{
  short sorted = 1;
  for (int i = 1; i < size; ++i)
  {
    if (niz[i] < niz[i - 1])
    {
      sorted = 0;
      break;
    }
  }

  if (!sorted)
  {
    result = 0xDEADFA11;
    return 0;
  }

  int median;
  if (size % 2 == 0)
    median = (niz[size / 2] + niz[size / 2 - 1]) / 2;
  else
    median = niz[size / 2];

  result = median;

  return 0;
}
