#include "types.h"
#include "stat.h"
#include "user.h"

int main(void){
    int i, j;
    int pid, tt, wt, rt;
    
    for(i = 0; i < 10; i++){
        if(fork() == 0){    //SE filho imprime
            for(j = 0; j < 1000; j++){
                printf(1, "child %d prints for the %d time\n", getpid(), j+1);
            }
            return 0;  //Finaliza execução do processo filho
        }
    }

    for(i = 0; i < 10; i++)
        wait(); //pai esperando execução dos filhos

    //imprime os tempos de execução e espera dos  filhos
    for(i = 1; i < 11; i++){
        pid = getpid();
        rt = runtime();
        wt = waittime();
        tt = turntime();
        printf(1, "Child %d: running time = %d, waiting time = %d, turnaround time = %d\n",
            pid+i, rt, wt, tt);
    }
    return 0;
}