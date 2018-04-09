//High Performance Computing for Data Science CUDA Programming
//Experimenting with arrays

#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Initialization function
__global__
void (int *arr, int size){
  int index = blockIdx.x * blockDim.x + threadIdx.x;
  int increment = gridDim.x * blockDim.x;

  for (int i = index; i < size; i += increment){
           arr[i] = 0;
        }
}

// Function to add i to array[i]
__global__
void addIValue(int *arr, int size){
  int index = blockIdx.x * blockDim.x + threadIdx.x;
  int increment = gridDim.x * blockDim.x;

  for (int i = index; i < size; i+= increment){
         arr[i] += i;
      }
}

// Function to print out array for verifying correctness
void printArray(int *ar, int size){
  printf("\n");
  printf("\n");
  for (int i = 0; i < size; i++){
    printf("%d ", ar[i]);
  }
}

int main(){

  int size = 32;
  int *array;
  int num_threads = 32;
  cudaMallocManaged(&array, size * sizeof(int));

  // Problem 1: Initialize an array of size 32 to all zeroes
  // in parallel

  int num_blocks = (size + num_threads - 1) / num_threads;
  initialize<<<num_blocks, num_threads>>>(array, size);
  cudaDeviceSynchronize();
  printf("Problem 1:");
  printArray(array, size);
  cudaFree(array);

  // Problem 2: Modify the size of array to 1024

  size = 1024;
  cudaMallocManaged(&array, size * sizeof(int));
  num_blocks = (size + num_threads - 1) / num_threads;
  initialize<<<num_blocks, num_threads>>>(array, size);
  cudaDeviceSynchronize();
  printf("\n\nProblem 2:");
  printArray(array, size);

  // Problem 3: In problem 2 create another kernel that
  // adds i to array[i]

  addIValue<<<num_blocks, num_threads>>>(array, size);
  cudaDeviceSynchronize();
  printf("\n\nProblem 3:");
  printArray(array, size);
  cudaFree(array);

  // Problem 4: In problem 2, change the array size to 8000
  // Check if answer to problem 3 still works

  size = 8000; // size is changed to 8000
  cudaMallocManaged(&array, size * sizeof(int));
  num_blocks = (size + num_threads - 1) / num_threads;
  addIValue<<<num_blocks, num_threads>>>(array, size);
  cudaDeviceSynchronize();
  printf("\n\nProblem 4:");
  printArray(array, size);
  cudaFree(array);
  cudaDeviceReset();

  return 0;
}
