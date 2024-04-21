#include <iostream>

extern "C"
{
  int factorial(int n);
}

int main()
{
  std::cout << "5! = " << factorial(5) << std::endl;
  return 0;
}

// int factorial(int n)
// {
//   if (n == 0) return 1;
//   return n * factorial(n - 1);
// }
