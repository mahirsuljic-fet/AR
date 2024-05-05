#include <stdio.h>

struct Student
{
    int id;
    char name[50];
    float gpa;
    int age;
};

void printStudent(struct Student s)
{
  printf("ID: %d\n", s.id);
  printf("Name: %s\n", s.name);
  printf("GPA: %.2f\n", s.gpa);
  printf("Age: %d\n", s.age);
}
