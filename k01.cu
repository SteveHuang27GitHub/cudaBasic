//nvcc k01.cu -o k01
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
            threadIdx.x,threadIdx.y,threadIdx.z,
            blockIdx.x,blockIdx.y,blockIdx.z,threadId);
}

int main(){
    dim3 threadABlock(3);
    dim3 blockAGrid(4);
    kernel<<<blockAGrid,threadABlock>>>();
    cudaDeviceSynchronize();
    return 0;
}
