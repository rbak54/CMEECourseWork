//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: multiple.c
//Desc: multiple files
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include <stdbool.h>
void print_int_array(const int array[], const int nelems, bool newline)  //nelems is no of elements, void function // const tells compiler  and person reading that values wont be changed- error if you change!
{
    int i = 0;//automatic local variables
    // const int a = 1; //would mean that a doesn't change
    //need to manually determine limits of arrays
    for (i = 0; i < nelems; ++i) {
        printf("%i", array[i]);
        if (i< (nelems-1)){
            printf(", ");
        }
    }
    if (newline== false){ // you've asked if it wants new line in function parameters
        return;
    }
    printf("\n");
    return;
}


