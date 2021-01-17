#include <stdlib.h>
#include <stdio.h>
#include <ucontext.h>

int main(){
	register int done = 0;
	ucontext_t one;
	ucontext_t two;
	getcontext(&one);
	printf("hello %d\n", done);
	if(!done){
		done=1;
		swapcontext(&two, &one);
	}
	return 0;
}


