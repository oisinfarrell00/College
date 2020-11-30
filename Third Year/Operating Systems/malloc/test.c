#include "dlmall.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>


int main(int argc, char *argv[]){
	int *test1 = dalloc(8);
	int *test2 = dalloc(24);
	int *test3 = dalloc(32);
	sanity();
	sanity2();
	dfree(test2);
	dfree(test1);
	sanity2();
}
