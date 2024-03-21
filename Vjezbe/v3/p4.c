const char* str = "Hello world";
char res[40];

int main()
{
  const char* s = str;
  int i = 0;

  while (*s != '\0')
  {
    res[i] = *s;
    if (*s > 96)
      if (*s < 123)
        res[i] = *s - 32;

    ++i;
    ++s;
  }

  res[i] = '\0';

  return 0;
}
