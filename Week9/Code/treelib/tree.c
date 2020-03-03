//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: tree.c
//Desc: pairs with tree.h- allocates memory for tree
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#include <stdlib.h>
#include "tree.h"
tree_t* new_tree(int num_taxa)
{
    //getting memory for tree
    int i = 0;
    tree_t *newt=NULL;
    newt = (tree_t*)calloc(1,sizeof(tree_t)); //confused
    if(newt !=NULL){
        newt->num_taxa  = num_taxa;
        newt->num_nodes = 2*num_taxa-1;
        newt->nodes     =(node_t*)calloc(newt->num_nodes, sizeof(node_t));
        if (newt->nodes ==NULL){
            //allocation failed; clean up and return null
            free(newt);
            return NULL;
        }
    //tree h defines a type ()
    for (i=0; i<newt->num_nodes; ++i){
        //assign memory indices to the nodes
        newt->nodes[i].mem_index=i;
        //label the tips with non 0;
        if (i<newt->num_taxa){
            newt->nodes[i].tip= i+1;
        }
    else {
        //label the internal nodes with 0 tip
        newt->nodes[i].tip=0;
    }
    }
    }
return newt;
}

void delete_tree(tree_t* tree)
{
//implement me!! - task for us
}


void tree_clear_connects(tree_t* t)
{
    int i = 0;
    for (i=0; i < t -> num_nodes; ++i){
        t->nodes[i].left = NULL;
        t->nodes[i].right=NULL;
        t->nodes[i].anc=NULL;
            }
}



//need to use gcc -c as not runnign anything rn
void tree_read_anc_table(int *anctable, tree_t* t){
    int i=0;
    int j=0;

//clear all connector pointers so that wee can assume null vlalues
    tree_clear_connects(t);

    //loop over all elements of anctabl at each position link that node to its ancestor
    for (i=0; i<t->num_nodes;++i){
        t->nodes[i].anc=&t->nodes[anctable[i]]; ///first nodes ancestor table pointed to ancester -assigns the ancester
        if (t->nodes[anctable[i]].left ==NULL){  //t->nodes[j].left == NULL is same thin. checking ancestors node hasnt already been assigned
                    t->nodes[anctable[i]].left = &t->nodes[i]; //puts element on left node
        }
        else {
            t->nodes[anctable[i]].right=&t->nodes[i]; //if left already assigned, put on right
        }
    }
     t->root=&t->nodes[t->num_nodes-1];
}
void tree_traverse(tree_t* t)
{
    node_traverse(t->root);
}
   
//error