//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: 3.1.c
//Desc: adding up different data types
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>

int main (void)
{
    char x = 'a';
    char a = 'a';
    char d = 'd';
    float z = 1.1;
    int e = 2;
    float y = 0;
    float r = 0;
    d = x + a ;
    y = e - z;
    r = x + z;

    printf(" d is : %c\n", d);
    printf("y is : %f\n",y);
    printf("r is : %f\n",r); //weird things happen!
    return 0  ;
}
