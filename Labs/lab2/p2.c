#include <stdio.h>

int gcd(int a, int b){
	if(b == 0)
		return a;
	else
		return gcd(b, a%b);
}
int main(){
	int a,b;
	printf("Enter a number: ");
	scanf("%d",&a);
	printf("Enter another number: ");
	scanf("%d",&b);
	int d = gcd(a,b);
	printf("The G.C.D is %d", d);
	return 0;
}
