#include <stdio.h>

struct Student
{
    int id;
    char name[50];
    float gpa;
    int age;
};

void printStudent(struct Student s);
// void printStudent(struct Student s)
// {
//   printf("ID: %d\n", s.id);
//   printf("Name: %s\n", s.name);
//   printf("GPA: %.2f\n", s.gpa);
//   printf("Age: %d\n", s.age);
// }

int main(void)
{
  struct Student student1 = { 101, "John Doe", 3.75, 20 };
  struct Student student2 = { 102, "Jane Smith", 3.90, 21 };

  printf("Student 1:\n");
  printStudent(student1);

  printf("Student 2:\n");
  printStudent(student2);

  return 0;
}
