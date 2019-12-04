//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: array1.c
//Desc: intro to arrays 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>   //only if input or output

int main(void)
{
    int i = 0; //interpretation: reserve memory with a read/write size of an int
    char j = 'c'; // Reserve memory with a read/write size of a char
    double pi = 3.14; //Reserve memory with a read/write size of double

    int intarray[4];  //specifying size- explicitly (contigious block of memory size of 4 integers)
    int intarray2[]= {0,0, 1, 4}; //specifying size- implitly (contigious block of memory size of 4 integers)
//NOT DYNAMIC
    int matrix[2][4]; //MAtrixes can be specified
    int nmatrix[2][4][3];

//reading and writing to and from arrays
//example: read from uninitialised array:
//reading / writing in C is 0 based:
j= intarray[0];
printf("intarray at position 0: %i\n", j);
printf("intarray at position 1: %i\n", intarray[1]);
printf("intarray at position 2: %i\n", intarray[2]);
printf("intarray at position 3: %i\n", intarray[3]);

printf("intarray2 at position 0: %i\n", intarray2[0]);
printf("intarray2 at position 1: %i\n", intarray2[1]);
printf("intarray2 at position 2: %i\n", intarray2[2]);
printf("intarray2 at position 3: %i\n", intarray2[3]);

intarray2[0]=3;
intarray2[1]=2;

printf("after assignment: \n");
printf("intarray2 at position 0: %i\n", intarray2[0]);
printf("intarray2 at position 1: %i\n", intarray2[1]);
printf("intarray2 at position 2: %i\n", intarray2[2]);
printf("intarray2 at position 3: %i\n", intarray2[3]);

printf("Reading out of intarray bounds: %i\n", intarray[-4]);

return 0;
}
