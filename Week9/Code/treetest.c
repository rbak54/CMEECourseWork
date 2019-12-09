
//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: treetes.c
//Desc: tree testing 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019

//this is where build script  is useful
#include "tree.h"
#include <stdlib.h>
int main(void)
{
    tree_t* t = NULL;
    int anctable[]={6,7,7,5,5,6,8,8,-1};
    t = new_tree(5); // doesnt know about this yet
    tree_read_anc_table(anctable, t);
    tree_traverse(t);
    return 0;
}