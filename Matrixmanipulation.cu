//Homework 5 Problem 1
//“ GPU Programming: Matrix Squaring (Version 1)” or “GPU: Programming Matrix Squaring (Version 2)”.
//Team : Resham Jhangiani, Phillip Ly
#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>


__global__ void  square ( unsigned int *matrix,  unsigned int *result,    unsigned int matrixsize) {
  unsigned id = blockIdx.x * blockDim.x + threadIdx.x;
  for (unsigned jj = 0; jj < matrixsize; ++jj) {
	
    for (unsigned kk = 0; kk < matrixsize; ++kk) 
    {
        result[id * matrixsize + jj] += matrix[id * matrixsize + kk] * matrix[kk * matrixsize + jj];
        	
    }
  }
}

void print(unsigned int *result, unsigned matrixsize)
{
printf("%u\n", *result);	
}

int main(void)
{
 int N=64;
 unsigned int *matrix;
 unsigned int *result;
 unsigned int matrixsize= N * sizeof(unsigned);

cudaMallocManaged(&matrix, matrixsize);
//printf("%u", *matrix);
square<<<1, N>>>(matrix, result, N);// N = 64

print(result, matrixsize);
cudaDeviceSynchronize();
cudaDeviceReset();
return 0;
}