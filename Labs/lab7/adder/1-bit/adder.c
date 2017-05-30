#include <stdio.h>

/*
   Use d0, d1, and carry_in to compute a return value.
   If necessary, use the carry_out pointer to return additional information
*/
int add_two_bits(int d0, int d1, int carry_in, int *carry_out)
{
  int ab=0;
  if (d0 == 1 || d1 == 1)
    ab = 1;
  if (d0 == 1 && d1 == 1)
    ab = 0;
  int S=0;
  if (ab == 1 || carry_in == 1)
    S = 1;
  if (ab == 1 && carry_in == 1)
    S = 0;
  carry_out = (d1*carry_in) + (d0*carry_in) + (d0*d1);
  sum = 2 * carry_out + S;
  return sum;
}

int main()
{
  int d0, d1, sum, c_out;

  printf("Enter binary digit 0: ");
  scanf("%d", &d0);
  /* Clean the user-generated input */
  d0 = !!d0;

  printf("Enter binary digit 1: ");
  scanf("%d", &d1);
  /* Clean the user-generated input */
  d1 = !!d1;

  sum = add_two_bits(d0, d1, 0, &c_out);
  if (c_out) {
    printf("%d + %d = %d with a carry\n", d0, d1, add_two_bits(d0, d1, 0, NULL));
  }
  else {
    printf("%d + %d = %d without a carry\n", d0, d1, add_two_bits(d0, d1, 0, NULL));
  }

  return 0;
}
