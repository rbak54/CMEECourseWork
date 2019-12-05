//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: tree.h
//Desc:header file for tree
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
//top 2 lines header guards-- looks for preexisting definition. if exists add below
#ifndef _TREE_H_
#define _TREE_H_
#include "node.h"

typedef struct tree
{
    int num_taxa;
    int num_nodes;
    node_t* nodes;
    node_t* root;
} tree_t;

tree_t* new_tree(int num_taxa);
void delete_tree(tree_t* tree);
void tree_read_anc_table(int *anctable, tree_t* t)


#endif