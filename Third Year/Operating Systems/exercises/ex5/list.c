//--------Libraries--------
#include <stdlib.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

//--------Constants--------
#define MAX 100


//--------Structures-------
typedef struct cell{
	int val;
	struct cell *next;
} cell;

typedef struct args{
	int inc;
	int id;
	cell *list;
}args;

//==================================================
cell centinel = {MAX, NULL}; // end of list marker
cell dummy = {-1, &centinel};
cell *global = &dummy;
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
//==================================================


void toggle(cell *lst, int r);

//--------Methods------------
void *bench(void *arg){
	int inc = ((args *)arg)->inc;
	int id = ((args *)arg)->id;
	cell *lstp = ((args *)arg)->list;
	
	for(int i=0; i<inc; i++){
		int r = rand()%MAX;
		toggle(lstp, r);
	}
}

void toggle(cell *lst, int r){
	cell *prev=NULL;
	cell *this=lst;
	cell *removed=NULL;
	
	pthread_mutex_lock(&mutex);
	
	while(this->val<r){
		prev=this;
		this=this->next;
	}
	if(this->val==r){
		prev->next=this->next;
		removed=this;
	}
	else{
		cell *new = malloc(sizeof(cell));
		new->val=r;
		new->next=this;
		prev->next=new;
	}
	pthread_mutex_unlock(&mutex);
	if(removed == NULL){
		free(removed);
	}
	return;
}

int main(int argc, char *argv[]){
	if(argc!=3){
		printf("usage: lsit <total> <threads> \n");
		exit(0);
	}
	int n = atoi(argv[2]);
	int inc = (atoi(argv[1])/n);

	
	printf("%d threads doing %d operations each\n", n, inc);
	
	pthread_mutex_init(&mutex, NULL);
	
	args *thra = malloc(n * sizeof(args));
	for(int i =0; i<n; i++){
		thra[i].inc=inc;
		thra[i].id=i;
		thra[i].list=global;
	}
	pthread_t *thrt = malloc(n*sizeof(pthread_t));
	for(int i=0; i<n; i++){
		pthread_create(&thrt[i], NULL, bench, &thrt[i]);
	}
	
	for(int i=0; i<n; i++){
		pthread_join(thrt[i], NULL);
	}
	
	printf("done\n");
	return 0;

}

