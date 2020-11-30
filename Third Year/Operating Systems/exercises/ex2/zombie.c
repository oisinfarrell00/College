#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(){
  int pid = fork();
  if(pid == 0){
    printf("Check the status\n");
    sleep(10);
    printf("And again\n");
    return 42;
  }
  else{
    sleep(20);
    int result;
    wait(&result);
    printf("The result was %d\n", WEXITSTATUS(result));
    printf("And again\n");
    sleep(10);
  }
  return 0;
}
