#include "types.h"
#include "stat.h"
#include "user.h"

int * running_times;
int * waiting_times;

int main(void){
    int i, j;
    
    for(i = 0; i < 10; i++){
        if(fork() == 0){    //SE filho imprime
            for(j = 0; j < 200; j++){
                printf(1, "child %d prints for the %d time\n", getpid(), j+1);
            }
            wait();
            return 0;  //Finaliza execução do processo filho
        }
    }
    for(i = 0; i < 10; i++)
        wait(); //pai esperando execução dos filhos
    printf(1, "ACABOUU\n");
    running_times = runtime();
    waiting_times = waittime();

    for(i = 1; i < 11; i++){
        printf(1, "Child %d: running time = %d, waiting time = %d, turnaround time = %d\n",
            getpid()+i, running_times[i-1], waiting_times[i-1], 
            running_times[i-1] + waiting_times+i);
    }
    return 0;
}