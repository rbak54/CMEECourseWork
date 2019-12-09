
//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: node.c
//Desc: who knows
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdio.h>
#include "node.h"

void node_traverse(node_t* n)
{
    //
 if (n->tip != 0){
     return;
 }   
printf("(");

 node_traverse(n->left);
 printf(",");
 node_traverse(n->right);
printf(")");
 return;
}