//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: pointersandfunctions.c
//Desc: pointers
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include <stdlib.h>

int *pos_first_odd(const int*,const unsigned long);

int *pos_first_odd(const int *integers, const unsigned long size) //reading declarations in c, start with name so pos_first_off is  function that takes an array of integers and returns a pointer to an integer
{
    unsigned long int c = 0;
    int *ret = NULL;
   // int* ret = NULL, a, *c same type so a is integer, but c is pointer
    //implementation code:
    ret = (int*)integers;

    while ((*ret % 2)==0 && c < size){
        ret= ret + 1;
        ++c;
    }

    if (c == size ){
        --ret;
        if ((*ret %2) != 0){
            return NULL;
            //++c;
}
}

    return ret;  // returns pointer to integer
    //* is dereference operator. so if want integer then *ret
}

int main (void)
{
    int *res = NULL;
    int intarray[]= {2,4,10,21,30};

    res= pos_first_odd(intarray, 5);

    printf("res now points to %i\n", *res);
    //*res = 20;

    *res = *res -  1;
    res = pos_first_odd(intarray, 5);
    if (res != NULL){  //check for null before using code that depends to it 
        printf("res now pints to : %i\n", *res);
    }
}

//dont dereference a null