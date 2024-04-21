#include <algorithm>
#include <iostream>
#include <vector>

extern "C"
{
  void partition(int* arr, int size, int (*predicate)(int));
}

int main()
{
  std::vector<int> niz { 4, 5, 1, 6, 9, 2, 3, 8, 0 };
  partition(niz.data(), niz.size(), [](int n) -> int { return n % 2 == 1; });
  for (const auto& el : niz)
    std::cout << el << " ";
  std::cout << std::endl;

  return 0;
}

static void part_impl(int* first, int* last, int (*pred)(int))
{
  if (first == last) return;
  if (pred(*first))
  {
    int tmp = *first;
    *first = *last;
    *last = tmp;
    --last;
  }
  else
    ++first;

  part_impl(first, last, pred);
}

void partition(int* arr, int size, int (*pred)(int))
{
  if (size < 2) return;
  part_impl(arr, arr + size - 1, pred);
}
