#include <assert.h>
#include <stdio.h>

int maxNum(int* arr, int size)
{
  assert(size > 0);
  assert(arr != NULL);

  int max = *arr;

  for (int i = 1; i < size; ++i)
    if (arr[i] > max)
      max = arr[i];

  return max;
}

int main()
{
  int size = 7;
  int array[30] = { 4, 7, 2, 11, 9, 3, 8 };

  printf("Max num: %d\n", maxNum(array, size));

  return 0;
}
