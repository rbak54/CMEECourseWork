//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: funcintro.c
//Desc: adding integers 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>

int add_integers(int, int); // A function prototype
int add_four_integers(int a, int b, int c, int d); //prototype with optional variable names. so prewarned that it exists and what inputs are

int add_four_integers(int a, int b, int c, int d)
{
    int result = 0;
    result = add_integers(a,b) + add_integers(c,d);
    return result;
}

int add_integers (int x,int y){
    int result = 0;
    result = x + y;
    return result; //return needed
    //return x+y also possible
}

int main(void){
    int a = 5;
    int b = 6;
    int result = 0;
    result = add_integers(a, b);
    printf("sum of a and b: %i\n", result);
    printf("sum of result and b: %i\n", add_integers(result,b));
    return 0;
}

