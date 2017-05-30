#include <float.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int main()
{
  int size;
  printf("How many grades does the student have? ");
  scanf("%d",&size);

  int *arr = (int *)malloc(size * sizeof(int));
  for(int i = 0; i < size; i++)
  {
    int grade;
    printf("Enter the next grade: ");
    scanf("%d", &grade);
    arr[i] = grade;
  }

  double average = 0;
  for(int i=0; i < size; i++)
  {
    average += arr[i];
  }

  average = average/size;

  free(arr);

  printf("The average grade is %3.2f",average );
  return 0;
}
