// Header
#include "dlmall.h"

// Libraries
#include <stdint.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <errno.h>
#include <assert.h>
#include <stddef.h>


// Constants
#define TRUE 1
#define FALSE 0
#define HEAD (sizeof(struct head))
#define MIN(size) (((size)>(8))?(size):(8))
#define LIMIT(size) (MIN(0)+HEAD+size)
#define MAGIC(memory) ((struct head*)memory-1)
#define HIDE(block) (void*)((struct head*)block+1)
#define ALIGN 8
#define ARENA (64*1024)

// Methods
struct head *after(struct head *block);
struct head *before(struct head *block);
struct head *split(struct head *block, int size);
struct head *new();
void detach(struct head *block);
void insert(struct head *block);
struct head *find(int size);
int adjust(size_t request);


struct head *merge(struct head *block);
void *dalloc(size_t request);
void dfree(void *memory);


// Structures
struct head{
	uint16_t bfree;
	uint16_t bsize;
	uint16_t free;
	uint16_t size;
	struct head *next;
	struct head *prev;
};
// A taken block that requires no next or prev
struct taken{
	uint16_t bfree;
	uint16_t bsize;
	uint16_t free;
	uint16_t size;
};

struct head *arena = NULL;
struct head *flist = NULL;



// --------AFTER--------
struct head *after(struct head *block){
	return (struct head*)((char*)(block) + HEAD + block->size);
}


// --------BEFORE--------
struct head *before(struct head *block){
	return (struct head*)((char*)(block) - (block->bsize+HEAD));
}


// --------SPLIT--------
struct head *split(struct head *block, int size){
	int rsize = block->size - (size+HEAD);
	block->size = rsize;
	
	struct head *split = (struct head*)after(block);
	split->bsize = rsize;
	split->bfree = block->free;
	split->size = size;
	split->free = block->free; // ask about this 
	
	struct head *aft = after(split);
	aft->bsize = size;
	return split;
}



// --------NEW--------
struct head *new(){
	if(arena != NULL){
		printf("one arena already allocated\n");
		return NULL;
	}
	struct head *new = mmap(NULL, ARENA, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	
	if(new == MAP_FAILED){
		printf("mmap failed: error %d\n", errno);
		return NULL;
	}
	uint size = ARENA-2*HEAD;
	
	new->bfree = FALSE;
	new->bsize = 0;
	new->free = TRUE;
	new->size=size;
	
	struct head *sentinel = after(new);
	sentinel->bfree=TRUE;
	sentinel->bsize=size;
	sentinel->free =FALSE;
	sentinel->size =0;
	
	arena = (struct head*)new;
	return new;
}


// --------DETACH--------
void detach(struct head *block){
	if(block->next != NULL){
		block->next->prev=block->prev;
	}
	if(block->prev != NULL){
		block->prev->next=block->next;
	}
	else{
		flist=block->next;
	}
}


// --------INSERT--------
void insert(struct head *block){
	block->next = flist;
	block->prev = NULL;
	if(flist != NULL){
		flist->prev=block;
	}
	flist=block;
}


// --------FIND--------
struct head *find(int size){
while(TRUE){
	for (struct head *taken = flist; taken != NULL; taken=taken->next){
		if(taken->size >= size){
			detach(taken);
			if(taken->size >= LIMIT(size)){
				struct head *splt = split(taken, size);
				insert(taken);
				taken=splt;
			}
			taken->free = FALSE;
			struct head *aft = after(taken);
			aft->bfree = FALSE;
			return taken;
		}
	}
struct head *block = new();
if(block == NULL){
	return NULL;
}
else{
	insert(block);
	}
}
}



// --------ADJUST--------
int adjust(size_t request){
	int remainder = request % ALIGN;
	if(remainder == 0){
		return MIN(request);
	}
	else{
		return MIN(request + (ALIGN - remainder));
	}
}


// --------SANITY--------
void sanity(){
{
	struct head *prev = NULL;
	for(struct head *index = flist; index!=NULL; index = index->next){
		if(index->prev != prev){
			printf("prev (%p) does not match\n", index->prev);
		}
		if(index->free == FALSE){
			printf("block (%p) not free in flist\n", index);
		}
		prev=index;
	}  
}
{
	struct head *index = arena;
	while(index->size != 0){
		struct head *aft = after(index);
		if(index->size != aft->bsize){
			printf("size and bsize do not match!\n Expected: (%d) Actual: (%d)", index->size, aft->bsize);
		}
		if(index->free != aft->bfree){
			printf("free and bfree do not match!\n Expected: (%d) Actual: (%d)", index->free, aft->bfree);
		}
		index=aft;	
		}
	}
	printf("Sanity 1: Check complete\n");
}


// --------SANITY2--------
void sanity2(){
	struct head *prev = NULL;
	for(struct head *index = flist; index!=NULL; index = index->next){
		printf("--------Sanity Check--------\n");
		printf("Flist Pointer: %p\n", index);
		printf("Prev: %p Next: %p\n", index->prev, index->next);
		printf("Size: %d\n", index->size);
		//prev=index; 
		printf("---sanity2 check complete---\n\n\n");
	}
}



// --------MERGE--------
struct head *merge(struct head *block){
	struct head *aft = after(block);
	if(block->bfree){
		struct head *tmp = before(block);
		detach(tmp);
		
		int tsize = block->size +tmp->size + HEAD;
		tmp->size = tsize;
		//tmp->free = TRUE;
		
		aft->bsize = tsize;
		block=tmp;
	}
	if(aft->free){
		detach(aft);
		int tsize = block->size + aft->size + HEAD;
		block->size = tsize;
		
		aft=after(aft);
		aft->bsize=tsize;
	}
	return block;
}



// --------DALLOC--------
void *dalloc(size_t request){
	if(request <= 0){
		return NULL;
	}
	int size = adjust(request);
	struct head *taken = find(size);
	if(taken == NULL){
		printf("taken was null\n");
		return NULL;
	}
	else{
		printf("Allocating: Size: (%d) Location: (%p)\n", taken->size, taken);
		return HIDE(taken); 
	}
}



// --------DFREE--------
void dfree(void *memory){
	if(memory != NULL){
		struct head *block = MAGIC(memory);
		block=merge(block);
		struct head *aft = after(block);
		block->free = TRUE;
		aft->bfree = TRUE;
		insert(block);
	}

}



