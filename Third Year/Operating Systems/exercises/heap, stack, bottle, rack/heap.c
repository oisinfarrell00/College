#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

const int read_only = 12345;
char global[] = "This is a global string";


int main(){
	int pid = getpid();
	char *heap = malloc(20);
	*heap = 0x61;
	printf("pointing to: %x\n", *heap);
	free(heap);
	char *foo = malloc(20);
	*foo=0x62;
	printf("foo pointing to: 0x%x\n", *foo);
	*heap=0x63;
	printf("or is it pointing to: 0x%x\n", *foo);
	
	
	

	return 0;

}
