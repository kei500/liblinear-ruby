%module liblinearswig
%{
#include "linear.h"
%}
%include linear.h
%include carrays.i
%array_functions(int,int)
%array_functions(double,double)

%inline %{
struct feature_node *feature_node_array(int size)
{
        return (struct feature_node *)malloc(sizeof(struct feature_node)*size);
}

void feature_node_array_set(struct feature_node *array, int i, int index, double value)
{
        array[i].index = index;
        array[i].value = value;
}

void feature_node_array_destroy(struct feature_node *array)
{
        free(array);
}

struct feature_node **feature_node_matrix(int size)
{
        return (struct feature_node **)malloc(sizeof(struct feature_node *)*size);
}

void feature_node_matrix_set(struct feature_node **matrix, int i, struct feature_node* array)
{
        matrix[i] = array;
}

void feature_node_matrix_destroy(struct feature_node **matrix)
{
        free(matrix);
}

static void print_string_stdout(const char *s)
{
        fputs(s,stdout);
        fflush(stdout);
}

void print_null(const char *s) {}

void enable_stdout() {
    set_print_string_function(&print_string_stdout);
}

void disable_stdout() {
    set_print_string_function(&print_null);
}

%}
