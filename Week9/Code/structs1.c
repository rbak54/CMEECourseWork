//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: structs1.c
//Desc: memory structures
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include <stdlib.h>

    struct listobj{    //making a type of data structure and calling it listobj
        int data;
        struct listobj* next; //pointers // next is a pointer to a list object which is a structure
    };

void traverse_list(struct listobj* lobj)
{
    //this function traverses a list recursively and calls out the integer stored inside
    if (lobj!= NULL){
        printf("int data %i\n", (*lobj).data);
        traverse_list((*lobj).next);   
        //printf("int data :%i")missed this line
         } 
}


int main (void)
{
//this tells compiler that list obj exists
struct listobj l1;  //listobj is a type
struct listobj l2;  
struct listobj l3;
struct listobj l4;


int intarray[3] = {10,21,33};

l1.data= 10; //putting data into struct //data is int
l2.data= 21;
l3.data=33;
l4.data=41;

l1.next= &l2;
l2.next = &l3;
l3.next= NULL;
//loop through a linked list:
struct listobj* p = NULL;
p=&l1;  //p is adress to a list object structure
//First, lets look a member selection via a pointer
int data = 0;
data = (*p).data; //brackets because of priorities 
//friendlier way of above line is: data=p-> data;
//so lets leverage to do some looping
while (p != NULL){
    printf("data in p : %i \n", (*p).data);
    p=p->next;
}
//lets traverse the list recursively using a functino
printf("Traversing recursively:\n");
traverse_list(&l1);

printf("\n");
//insert a new element
l4.next=&l2;
l1.next=&l4;

p=&l1;
while (p!=NULL){
    printf("data in p: %i\n", (*p).data);
    p = p->next;
}


printf("Traversing recurdively :\n");
traverse_list(&l1);
printf("\n");
return 0;


}