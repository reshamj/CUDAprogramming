//Problem 1. 
//Write a CUDA program to initialize an array of size 32 to all zeros in parallel.

#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>
//Kernel function to initialize array
__global__
void initialize(int *arr, int size){
  int index = blockIdx.x * blockDim.x + threadIdx.x;
  int increment = gridDim.x * blockDim.x; 

  for (int i = index; i < size; i += increment){ 
           arr[i] = 0; 
        }
}

void print(int *ar, int size){
  printf("\n");
  for (int i = 0; i < size; i++){
    printf("%d ", ar[i]);
  }
  printf("\n");
}


int main(void){
printf("Homework 4\n Problem 1: Initialize an array of size 32 to all zeros in parallel ");

//Declare int array
int size = 32;
int *array;
int gpuThread = 32;
int arraySize = size * sizeof(int);
cudaMallocManaged(&array, arraySize);
int blocks = (size + gpuThread - 1) / gpuThread;
initialize<<<blocks, gpuThread>>>(array, size);

print(array, size);

cudaFree(array);
cudaDeviceReset();
return 0;
}
