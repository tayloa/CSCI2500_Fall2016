#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void tri ( int n ){
	int i, j;
	for(i = 1;i <= n; i++){
		for(j = 1; j <= i; j++)
			printf( "*" );
		printf( "\n" );
	}
}

void hyp ( int n) {
	double x = n;
	double y = sqrt( pow(x,2) + pow(x,2) );
	printf("Hypotnuse: %6.2f", y);
}	

int main(){
	int x;
	printf( "What is n? " );
	scanf( "%d", &x);
	if (x % 2 != 0){
		printf( "Please enter an even number: " );
		scanf( "%d", &x );
	}
	tri ( x );
	hyp ( x );
	return 0;
}