// int foo(int);
// int bar(int);

int fib(int n)
{
  if (n < 2)
    return 1;
  else
  {
    // pojednostavljenja, radi lakseg razmisljanja
    //
    // return foo(n - 1) + bar(n - 2);
    //
    // int t1 = fib(n - 1); // foo(n - 1);
    // int t2 = fib(n - 2); // bar(n - 2);
    // int rez = t1 + t2;
    // return rez;

    return fib(n - 1) + fib(n - 2);
  }
}
