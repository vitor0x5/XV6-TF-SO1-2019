#include "types.h"
#include "stat.h"
#include "user.h"

int main(void){
    int i, j, pid;

    if(fork() != 0)
        wait();     //PAI fica esperando os filhos executarem
    else{
        for(i = 0; i < 9; i++){
            pid = fork();
            if(pid == 0){       ///SE for filho pula para printf 
                break;
            }
        }
        for(j = 0; j < 1000; j++){
            printf(1, "child %d prints for the %d time\n", getpid(), j+1);
        } 
    }
    printf(1, "PAAAAI\n");
    return 0;
    
}