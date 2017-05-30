#include <stdio.h>
#include <stdlib.h>
#include <math.h>

long fact(long x) {
	long total = x;
	if (x <= 1)
		return 1;
	 total = x * fact(x-1);
	return total;
}

int main(){
	long x;
	printf("Factorial of what positive number? ");
	scanf( "%ld" , &x);
	printf ( "%ld" , fact( x ));

	return 0;
}