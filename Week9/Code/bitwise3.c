//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: bitwise3.c
//Desc:  pointers usage and doing arithmetic
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include <stdlib.h>


int main (void)
{
    int i = 0;
    int j = 1;
    int *p = NULL; 
    int *q = NULL; //null pointer. null pointers can be used to denote ends of arrays. bc used oftn, should always initalise null 
    
    p = &i; //address of i
    q=&j;
    printf("Value of i before indirection: %i\n", i);
    printf("Value of i via indirection: %i\n",*p);

    i = 4;
    *p = 5;
//print f - %p means pointer
    printf("Value of i after indirection: %i\n",i);
    printf("Adress if i using & oprator: %p\n",&i);//to see adress
    printf("Adress if i using p: %p\n",p);//to see adress

    printf("another way to read a pointer: %i\n", *(&i));
    printf("Arithmetic via pointers %i\n", *p+*q);
    return 0 ;
}