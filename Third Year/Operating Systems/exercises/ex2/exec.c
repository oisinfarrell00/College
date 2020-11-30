#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/stat.h>

int main(){
  int pid = fork();
  
  if(pid == 0){
    int fd = open("
  }
  else{
    wait(NULL);
    printf("We are done\n");
  }
  return 0;
}
