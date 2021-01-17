#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>


int main(){
	int pid = fork();
	if(pid == 0){
		execlp("ls", "ls", NULL);
	}
	else{
		wait(NULL);
		printf("done");
	}
	return 0;
}
