#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>



int main(){
char*heap=malloc(20);
 printf("the heap variable at:%p\n",&heap);
 printf("pointing to:%p\n",heap);  
  int pid = getpid();
  unsigned long p = 0x1;

 back:
  printf("p (0x%lx): %p \n", p, &p);
  printf("back: %p \n", &&back);
  
  printf("\n\n /proc/%d/maps \n\n", pid);
  char command[50];
  sprintf(command, "cat /proc/%d/maps", pid);
  system(command);
  return 0;
}


