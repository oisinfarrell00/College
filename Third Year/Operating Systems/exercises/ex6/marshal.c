#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <sys/wait.h>


#define ITERATIONS 10
#define BURST 10

int main(){
	int descr[2];
	assert(0 == pipe(descr));
	if(fork()==0){
		for(int i=0; i<ITERATIONS; i++){
			double buffer;
			read(descr[0], &buffer, sizeof(double));
			printf("Recieved %f\n", buffer);
			sleep(1);	
		}
	}
	for(int i=0; i<ITERATIONS; i++){
		double pi = 3.14 * i;
		write(descr[1], &pi, sizeof(double));
	}
	printf("Producer done\n");
	wait(NULL);
	printf("all done");

}

