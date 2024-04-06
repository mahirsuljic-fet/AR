// short size = 5;
// short niz[5] = { 1, 19, 350, 740, 1522 };
short size = 6;
short niz[6] = { 1, 19, 350, 740, 1552, 2020 };
int result = 0;

#define REG int     // registar koji sadrzi vrijednost
#define REGp short* // registar koji sadrzi adresu

REG t0;
REGp t1;
REGp t2;
REGp t3;
REG t4;
REG LO;

int main()
{
  t0 = 1;           // sorted
  t1 = niz + 1;     // &niz[i]
  t2 = niz;         // &niz[i-1]
  t3 = niz + size;  // &niz[size]

  while (t1 != t3)
  {
    if (*t1 < *t2)
    {
      t0 = 0;
      break;
    }

    ++t1;
    ++t2;
  }

  if (t0 == 0)
  {
    result = 0xDEADFA11;
    return 0;
  }

  t1 = niz;

  LO = size / 2;
  t4 = LO;
  t2 = t1 + t4;

  if (size % 2 == 0)
  {
    t3 = t1 + t4 - 1;

    t0 = *t2 + *t3;
    LO = t0 / 2;
    t0 = LO;
  }
  else
    t0 = *t2;

  result = t0;

  return 0;
}
