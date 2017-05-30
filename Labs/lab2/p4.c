#include <stdio.h>

int Fib(int n)
{
  int  x[n+1];
  x[0] = 0;
  x[1] = 1;
  for(int i = 2; i <= n; i++){
    x[i] = x[i-1] + x[i-2];
  }
  return x[n];
}

int main() {
  int n;
  printf("Enter number (Array): ");
  scanf("%d",&n);
  printf("Result: %d",Fib(n) );
  return 0;
}
