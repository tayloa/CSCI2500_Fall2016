#include <stdio.h>

int main()
{
  unsigned int x;
  printf("Enter x: ");
  scanf("%x", &x);
  printf("%x = %u\n", x, x);
  for (int i = 0; i < 32; i++) {
    printf("%d", x & 1);
    x = x >> 1;
  }
  return 0;
}
