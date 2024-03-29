// Prevesti dati kod u assembler
// (zadatak nije bio u main-u, samo ovih 8 linija koda unutar main-a,
// ali sam ubacio u main da bi se mogao pokrenuti)

int main()
{
  int t0 = 0xDEADBEEF;
  int t1;

  if (t0 > 40000)
    t1 = 0xDEADC0DE;
  else if (t0 > 80000)
    t1 = 0xDEAD2BAD;
  else
    t1 = 0xDEADD00D;

  return 0;
}
