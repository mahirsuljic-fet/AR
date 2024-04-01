int main()
{
  int a = 5 % 3;
  constexpr int c = 5 % 3; // samo postoji u c++, nema u c
  // kada koristimo constexpr kompajler izracuna vrijednost
  // koju vrijabla c treba imati (2), (u ovom slucaju umjesto 
  // 4 instrukcije svede se samo na jednu, samo ucita 2 u c)
}
