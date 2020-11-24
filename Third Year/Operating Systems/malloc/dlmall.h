#include <stddef.h>


#ifndef DLMALL_H
#define DLMALL_H



void dfree(void *memory);
void *dalloc(size_t request);
void sanity();
void sanity2();



#endif



