#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <sys/socket.h>
#include <sys/un.h>


#define SERVER "lower"
#define MAX 512
#define CLIENT "help"

int main(void){
	int sock;
	char buffer[MAX];
	
	assert((sock = socket(AF_UNIX, SOCK_DGRAM, 0))!=-1);
	
	struct sockaddr_un name = {AF_UNIX, SERVER};
	unlink(SERVER);
	assert(bind(sock, (struct sockaddr *)&name, sizeof(struct sockaddr_un))!=-1);
	struct sockaddr_un client;
	int size = sizeof(struct sockaddr_un);
	
	while(1){
		int n;
		n=recvfrom(sock, buffer, MAX-1, 0, (struct sockaddr*)&client, &size);
		if(n=-1)
			perror("server");
		buffer[n]=0;
		printf("Server recieved: %s\n", buffer);
		unlink(CLIENT);
		exit(0);
	}
}
