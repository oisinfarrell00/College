#include <stdlib.h>
#include <stdio.h>
#include <ucontext.h>

#define MAX 10

static int running;

static ucontext_t one;
static ucontext_t two;
static ucontext_t cnt_main;

void yield(){
	printf("-yield-\n");
	if(running ==1){
		running = 2;
		swapcontext(&one, &two);
	}else{
		running = 1;
		swapcontext(&two, &one);
	}
}

void push(int p, int i){
	if(i<MAX){
		printf("%d%*s push\n", p, i, " ");
		push(p, i+1);
		printf("%d%*s pop\n", p, i, " ");
	}else{
		printf("%d%*s top\n", p, i, " ");
		yield();
	}
}

int main(){
	char stack1[8*1024];
	char stack2[8*1024];
	getcontext(&one);
	one.uc_stack.ss_sp=stack1;
	one.uc_stack.ss_size = sizeof(stack1);
	makecontext(&one, (void (*) (void))push, 2, 1, 1);
	
	getcontext(&two);
	two.uc_stack.ss_sp=stack2;
	two.uc_stack.ss_size = sizeof(stack2);
	makecontext(&two, (void (*) (void))push, 2, 1, 1);
	
	running = 1;
	
	swapcontext(&cnt_main, &one);
	
	return 0;
	
}
