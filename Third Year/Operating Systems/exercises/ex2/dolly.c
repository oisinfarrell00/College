#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(){
  int pid = fork();
  
  if(pid == 0){
    int child = getpid();
    printf(" I am the child %d\n", getpid());
   // printf(" I am the child %d in group  %d\n", child, getpgid(child));
   sleep(1);
  }
  else{
    int parent = getpid();
   // printf(" I am the parent  %d and my parent is  %d\n", parent, getpgid(parent));
    printf(" My child is called %d\n", pid);
    wait(NULL);
    printf("My child has terminated \n");
  }
  printf("This is the end %d\n", getpid());
  return 0;
}
