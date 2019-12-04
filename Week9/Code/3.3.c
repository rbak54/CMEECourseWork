//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: 3.3.c 
//Desc:  increments 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>

int main (void)
{
    int x = 3;
    //int y = 0;
    int z = 3;
    int a = 0;
    int b = 0;
    a = ++x;
    b = z++;
    printf("x is : %i\n", x);
    //printf("y is : %i\n",y);
    printf("z is : %i\n", z);
    printf("a is : %i\n", a);
    printf("b is : %i\n", b);

    return 0;

}
