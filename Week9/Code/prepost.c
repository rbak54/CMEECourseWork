//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: prepost.c
//Desc: incrementation.c
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>

int main(void)
{
    int x = 6;
    int y = 0;

    //postfix incrementation
    y= ++x;
    printf("y after postfix assignment: %i\n",y);
    printf("x after postfix assignment: %i\n",x);


    //prefix incrementation
    y= x++;
    printf("y after prefix assignment: %i\n",y);
    printf("x after prefix assignment: %i\n",x);

    //Deincremet x
   // printf("x with prefix deincrement in function call: %i\n",x--); //this is undefined so we may all get different values
   int z = x--;
   printf("x after deincrement: %i\n",x);
   printf("x from postfix deincrement: %i\n",z);

   return 0;
}
