//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: dynarray.c
//Desc: dynamic arrays, malloc and calloc
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    int numsites = 30;
    int *sppcounts= NULL;
    
    sppcounts= (int*)malloc(numsites *sizeof(int));
    //check malloc sucessded and returned a valid pointer
    if (sppcounts==NULL){
        printf("insuffivient mempru for operation!\n");
        return 1;
    }
    sppcounts[20]= 44;


    int i = 0;
    for (i=0; i<numsites; ++i){
        printf("data ins dite %i is : %i\n",i , *(sppcounts+i));  //spcounts[i] is same as *(sppcounts +i)
    }
//malloc no guarentees that will be empty

//fee memory, return it to the system before overwriting the pointer to that memory:
free(sppcounts); //if allocate mmeoru need to free it again
sppcounts=NULL; 
sppcounts=(int*)calloc(numsites,sizeof(int)); //necessary for c++. not sure what it means
    if (sppcounts==NULL){
        printf("insuffivient mempru for operation!\n");
        return 1;
    }
sppcounts[20] = 44;
    for (i = 0; i<numsites;++i){
        printf("data in site %i is %i\n", i , sppcounts[i]);
    }

    free(sppcounts);
    sppcounts=NULL;
    return 0;
    }
//check for null when using pointers ESP calloc and malloc- if no available memory, then will return null

    //caloc- clear memory allocation