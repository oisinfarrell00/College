#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "rand.h"

#define ROUNDS 10
#define BUFFER 100
#define LOOP 100000

int main(){
  void *buffer[BUFFER];
    for(int i = 0; i<BUFFER; i++){
      buffer[i]=NULL;
    }
  void *init = sbrk(0);
  void *current;

  printf("The initial top of the heap is %p.\n", init);

  int index = rand()%BUFFER;
    if(buffer[index] != NULL){
			      free(buffer[index]);
    }

    for(int j = 0; j< ROUNDS; j++){
      for(int i = 0; i < LOOP; i++){
	int index = rand()%BUFFER;
	if(buffer[index] != NULL){
	    free(buffer[index]);
	  }
	size_t size = requests();
      int *memory;
      memory = malloc(size);
	  
      if(memory == NULL){
	fprintf(stderr, "malloc failed\n");
	return(1);
      }
      buffer[index] = memory;
      *memory = 123;
      free(memory);
      printf("I am here\n");
	};
    current = sbrk(0);
    int allocated = (int)((current - init)/1024);
    printf("%d\n", j);
    printf("The current top of the heap is %p.\n", current);
    printf("    increased by %d Kbytes\n", allocated);
  
  return 0;
}
}
