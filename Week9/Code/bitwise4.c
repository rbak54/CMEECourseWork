//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: bitwise4.c
//Desc:  pointers more
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int integers[]={2,33,4,10,11};
    int (*aintptr)[]= NULL; //pointer to an array of integers
    int *aintptr2= NULL; //pointer to an array

    aintptr= &integers;
    printf("The value at index 1 in intarray via indirection: %i\n",(*aintptr)[1]); //star- pointer so go to that , [] because array , but operater precedence means you need brackets (otherwise tries to subscript a pointer)
    
    aintptr2= integers;

    printf("Dereferencing pointer to an array: %i\n", *aintptr2);
    printf("get second value by pointer arithmetic %i\n", *(aintptr2 + 1));
    printf("Get second value by array subscripting a pointer: %i\n", aintptr2[1]);

    int *endofarray= NULL; //:lets point to a specific value
    endofarray= &integers[4];//points to last element in array
    
    for (aintptr2=integers; aintptr2<= endofarray; ++aintptr2){
        printf("%i ", *aintptr2);
    }
    printf("\n");
    return 0;
}