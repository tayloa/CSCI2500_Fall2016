#include <stdio.h>


int Fib(int n)
{
   if ( n == 0 )
      return 0;
   else if ( n == 1 )
      return 1;
   else
      return ( Fib(n-1) + Fib(n-2) );
}

int main() {
  int n;
  printf("Enter number (Recursive): ");
  scanf("%d",&n);
  printf("Result: %d",Fib(n) );
  return 0;
}
