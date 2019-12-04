//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: vars2.c
//Desc: variables more 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
int main (void)
{
    int a = 7;
    int b = 2;
    float c = 0;
    int d = 0;

    c =7.0/2.0;
    d = a/b;

    printf("Result of literal expression: %f\n", c);
    printf("Results of variable expression:%i\n", d);
    /*when both int, throws away any fraction so 3 is result
     when c is initially defined as  float and %f , still throws away fraction so 3.000 
     when c =(float)7/2 as well , ok
     or c=7.0/2
     */

    return 0;
}
