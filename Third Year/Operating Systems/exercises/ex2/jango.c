#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sys/stat.h>

int main(){
  int pid = fork();
  if(pid == 0){
    int fd = open("quotes.txt", O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
    dup2(fd, 1);
    execl("boba", "boba", NULL);
    printf("This only happens if it failed\n");
  }
  else{
    wait(NULL);
  }
}
