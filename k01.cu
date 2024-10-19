//nvcc k01.cu -o k01 -gencode arch=compute_89,code=compute_89 --threads 0 --std=c++11 -lcufft
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#include <stdio.h>
__global__ void kernel(){
    long blockId = blockIdx.z  *  gridDim.x*gridDim.y
                 + blockIdx.y  *  gridDim.x
                 + blockIdx.x;
    long threadsPerBlock = blockDim.x*blockDim.y*blockDim.z;
    long threadId= threadIdx.z  *  blockDim.x*blockDim.y
                 + threadIdx.y  *  blockDim.x
                 + threadIdx.x
                 + blockId * threadsPerBlock;
    printf("ThreadIdx.x,y,z=%d,%d,%d,%d,%d,%d,%ld\n",
            blockIdx.z,blockIdx.y,blockIdx.x,
            threadIdx.z,threadIdx.y,threadIdx.x,threadId);
}

int main(){
    dim3 threadABlock(2,2,2);
    dim3 blockAGrid(2,2,2);
    kernel<<<blockAGrid,threadABlock>>>();
    cudaDeviceSynchronize();
    return 0;
}
