//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: bitwise1.c
//Desc:  exploring bitwise operations , one's complement
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include <limits.h>  // defines some macros that are useful for us

int main (void)
{
    unsigned int a = 0;
    unsigned int b = 1;
    unsigned int c = 1;
    /*
    *0: 00000000
    *1: 00000001
    *2: 00000010
    *3: 00000011
    *4: 00000100
    *5: 00000101
    *6: 00000110
    *7: 00000111
    **/
   //set c to 2
   c=b <<1;
   printf("b left-shifted by 1 is: %i\n",c);

   c=0;
   c= (b <<2)| b;
   printf("c is now %i\n",c);
//the ones complement operator : ~ (a unary operator)

    c = 0;
    c =~c;

    printf("The one's complement of 0 is: %u\n",c);
    printf("The maximum size of unsigned int is: %u\n", UINT_MAX);




   return 0;
}