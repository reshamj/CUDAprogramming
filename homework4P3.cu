//Problem 3. 
//Write a CUDA program: In Problem 2, create another kernel that adds i to array[i]

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

//Kernel function to add i to a[i]
__global__
void addIValue(int *arr, int size){
  int index = blockIdx.x * blockDim.x + threadIdx.x;
  int increment = gridDim.x * blockDim.x;

  for (int i = index; i < size; i+= increment){ 
         arr[i] += i; 
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
printf("Homework 4\n Problem 3:  In Problem 3, create another kernel that adds i to array[i]");

//Declare int array
int size = 1024;
int *array;
int gpuThread = 32;
int arraySize = size * sizeof(int);
cudaMallocManaged(&array, arraySize);
int blocks = (size + gpuThread - 1) / gpuThread;
initialize<<<blocks, gpuThread>>>(array, size);

//add value of i to array 
addIValue<<<blocks, gpuThread>>>(array, size);
cudaDeviceSynchronize();

print(array, size);

cudaFree(array);
cudaDeviceReset();
return 0;
}
