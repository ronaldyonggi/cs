#include <cs50.h>
#include <stdio.h>

int main(void) {
   // get numbers from user
   int x = get_int("x: ");
   int y = get_int("y: ");

   // Below is wrong because result of x/y is calculated as int BEFORE assigned to z.
   // Thus the decimal places associated with result of x/y is truncated (removed).
   // float z = x / y;
   // If we use the code above and use x=1 and y=2, result will be 0!

   // Use casting to force the type of x and y to floats
   float z = (float) x / (float) y;

   printf("%f\n", z);
}