#include <iostream>
#include <string>

extern "C"
{
  int isPalindome(const char*, int);
}

int main()
{
  std::string rijec;
  std::cout << "Unesite rijec: ";
  std::cin >> rijec;

  if (isPalindome(rijec.c_str(), rijec.size()))
    std::cout << "Rijec je palindrom" << std::endl;
  else
    std::cout << "Rijec nije palindrom" << std::endl;

  return 0;
}

int isPalindome(const char* s, int len)
{
  if (len < 2) return 1;
  return s[0] == s[len - 1] && isPalindome(s + 1, len - 2);
}
