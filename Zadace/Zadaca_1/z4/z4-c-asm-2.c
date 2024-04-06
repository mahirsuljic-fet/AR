short size = 5;
short niz[5] = { 1, 19, 350, 740, 1522 };
// short size = 6;
// short niz[6] = { 1, 19, 350, 740, 1552, 2020 };
int result = 0;

#define REG int     // registar koji sadrzi vrijednost
#define REGp short* // registar koji sadrzi adresu

REG t0;
REGp t1;
REGp t2;
REGp t3;
REG t4;
REG t5;
REGp t6;
REG LO;

int main()
{
  t0 = 1;          // sorted
  t1 = niz + 1;    // &niz[i]
  t2 = niz;        // &niz[i-1]
  t3 = niz + size; // &niz[size]
  t6 = niz;        // &niz[0]

WHILE:
  if (t1 == t3) goto WHILE_OUT;

  t4 = *t1 < *t2;

  if (t4 == 0) goto INCREMENT;

  t0 = 0;
  goto WHILE_OUT;

INCREMENT:
  t1 = t1 + 1;
  t2 = t2 + 1;
  goto WHILE;

WHILE_OUT:
  if (t0 != 0) goto IF1_OUT;

  t0 = 0xDEADFA11;
  goto END;

IF1_OUT:
  t0 = size;
  t5 = t0 & 1;

  LO = t0 / 2;
  t4 = LO;
  t2 = t6 + t4;

  if (t5 != 0) goto ELSE;

  t3 = t6 + t4;
  t3 = t3 - 1;

  t0 = *t2 + *t3;
  LO = t0 / 2;
  t0 = LO;

  goto END;

ELSE:
  t0 = *t2;

END:
  result = t0;
  return 0;
}
