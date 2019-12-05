//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: safearray.c
//Desc: safe array
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include <stdlib.h>

struct intvec{
    size_t nelems; //intege typer (unisgned long int)
    int* data;
};  //declaratino of type  add semicolon

typedef struct intvec intvec_t;   //creates an alias, saveingg keystrokes-- so now intvec_t means struct intvec

intvec_t *new_intvec(size_t nelems){
    intvec_t*newvec=NULL;
    newvec=(intvec_t*)calloc(1,sizeof(intvec_t));

    if (newvec !=NULL){
        //save the array bounds
        newvec->nelems=nelems;
        //allocate the memory for the 'array':
        newvec-> data = (int*)calloc(nelems, sizeof(intvec_t));
        if (newvec->data==NULL) {
            //check data fully allocated- i.e not null. if faled clean up the resource and exit the function, returning NULL
            free(newvec);
            return NULL;
        }
    }
return newvec;
}

void delete_intvec(intvec_t* ints)
{
    //alwats check that the pointer to memory being freed is non-null
    if (ints !=NULL){
        if (ints->data !=NULL){
            free(ints->data);
            ints->data=NULL;
        }
        free(ints);
    }
}

//function sets data in intvec at a particular position , returns 0 if sucess and returns -1 id failed (i.e out of bounds)
int set_data(int data , int index, intvec_t* ints)
{
    if (index>= ints->nelems){
        return -1;    //prevent you reading outside of bounds of data
    }
    ints -> data[index] =data;
    return 0;
}



//gets data from a particular index in the intvec l returns 0 if sucess; returns -1 if failed (ie. out of bounds)
int get_data(int *res,int index, intvec_t* ints)
{
if (index < ints->nelems){
    *res=ints->data[index];
    return 0;
    }
return -1;
}


int main(void){
    intvec_t *sppcounts = new_intvec(30);
    int i =0;
    int val = 0;
    for (i=0; i<sppcounts->nelems; ++i){
        set_data(i+3,i,sppcounts);
    }
printf("all of the elements of sppcounts:\n");
for (i=0; i<sppcounts->nelems; ++i){
    get_data(&val, i ,sppcounts);
    printf("%i", val);
}
printf("\n");

int error=0;
error=get_data(&val,50,sppcounts);
if (error !=0){
    printf("error! tried to read out of bounds ,you muppet!\n");
}

return 0;
}
