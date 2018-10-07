//Homework3
//Resham Jhangiani, Phillip Ly
//Used static array with values 3,1,7,1,4,1,6,3 as mentioned in the problem
#include <mpi.h>

#include <stdio.h>

#include <stdlib.h>
int main(int argc, char** argv) {

        int rank,size,i=0;

        int *dataset, localdata, localrecv;
        //declared static array from the problem
        int local_array[10] = {3,1,7,1,4,1,6,3};

        int beginingindex[10], endindex[10];

        const int root=0;

        MPI_Init(&argc, &argv);

        MPI_Comm_rank(MPI_COMM_WORLD, &rank);

        MPI_Comm_size(MPI_COMM_WORLD, &size);

        i = rank;

        localdata = local_array[i];

        printf("[Process %d]: has local data %d\n", rank, localdata);



        //MPI_Scan(sendbuf,recvbuf, count, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
        MPI_Scan(&localdata,&localrecv, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);

        //Just be a little in order
        MPI_Barrier(MPI_COMM_WORLD);

        //Calcualting start and end index for each process
        endindex[rank] = localrecv;
        beginingindex[rank] = ((endindex[rank] - localdata) + 1);
        printf("Process %d will receive the array portion between index %d - %d \n", rank, beginingindex[rank] , endindex[rank]);

        MPI_Finalize();

        return 0;

}
