#include <iostream>

struct Foo
{
    // char c;
    double d;
    short s;
    char c;
};

int main()
{
  std::cout << sizeof(Foo) << std::endl;

  return 0;
}
