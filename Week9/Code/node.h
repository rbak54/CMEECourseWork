//Author: Ruth Keane ruth.keane19@imperial.ac.uk
//Script: node.h
//Desc: header file for node structure 
//Input: none
//Arguments: none
//Output: none
//Date: Dec 2019
#ifndef _NODE_H
#define _NODE_H
// a typedef to save us keystrokes
//typedef <known type. <new alias>
typedef struct _node node_t;
typedef struct  _node {
    node_t*left; //pointer to left descendent
    node_t*right; //pointer to right descendent
    node_t*anc; //pointer to ancestor
    int   tip;
    int   mem_index;
    char *label;
} node_t;



#endif
