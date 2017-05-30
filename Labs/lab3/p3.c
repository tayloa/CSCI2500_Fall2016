#include <float.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

struct student
{
  char name[100]; // No one should have a name longer than this
  int *grades; // This is the pointer to hold the (integer) grades
  int count; // The number of grades
};

int main()
{
  int size; // number of students
  struct student* students; // array of students
  printf("How many students are there? ");
  scanf("%d",&size );
  students = (struct student*) malloc(size * sizeof(struct student)); // allocate space for array of students

  for(int i = 0; i < size; i++)
  {
    struct student tempstudent;

    printf("Enter the name of student %d: ", i+1);
    scanf("%s",&tempstudent.name[i]);
    printf("How many grades does %s have? ", tempstudent.name);
    scanf("%d",&tempstudent.count);
    tempstudent.grades = (int *)malloc(tempstudent.count * sizeof(int)); // allocate space for student's grades

    // add grades to student's array
    for(int j = 0; j < tempstudent.count; j++)
    {
      printf("Enter the next grade: ");
      scanf("%d", &tempstudent.grades[j]);
    }
    students[i] = tempstudent;
  }

  // Print student averages
  for(int i = 0; i < size; i++)
  {
    double average = 0;
    for(int j=0; j < students[i].count; j++)
    {
      average += (students[i]).grades[j];
    }

    average = average/students[i].count;
    printf("\n%s has an average grade of %3.2f\n", students[i].name, average);
  }

  return 0;
}
