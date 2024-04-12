#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "abstract_syntax_tree.h"

expression_node* init_exp_node(char* val, expression_node* left, expression_node* right) {
    expression_node* node = (expression_node*)malloc(sizeof(expression_node));
    if (node == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    node->value = strdup(val);
    if (node->value == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(EXIT_FAILURE);
    }
    node->left = left;
    node->right = right;
    return node;
}

void display_exp_tree(expression_node* exp_node) {
    if (exp_node != NULL) {
        printf("%s\n", exp_node->value);
        display_exp_tree(exp_node->left);
        display_exp_tree(exp_node->right);
    }
}

void free_exp_tree(expression_node* exp_node) {
    if (exp_node != NULL) {
        free_exp_tree(exp_node->left);   // Free left subtree
        free_exp_tree(exp_node->right);  // Free right subtree
        free(exp_node->value);           // Free value
        free(exp_node);                  // Free node itself
    }
}
