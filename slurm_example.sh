#!/bin/bash
#SBATCH --time=8-00:00:00     # Walltime  COMPUTATIONAL TIME: ONCE ELAPSED IT WILL STOP day-hour:min:sec 
#SBATCH --mem-per-cpu=16G  # memory/cpu
#SBATCH --job-name=GraphRNN_MIS_P3_500_N100_5000_lr_1  # CAREFUL TO CHANGE IT ALSO IN THE RUN LINE
#SBATCH --partition=general  # This is the default partition
#SBATCH --gres=gpu:1          # Request 1 GPU
#SBATCH --output=/scratch/username/programFolder/results_%j.txt  # all the things that usually would be printed in the screen are going to be printed into this file.
#SBATCH --error=/scratch/username/programFolder/errors%j_error.txt # the executing errors and warnings will appear in this file
#SBATCH --cpus-per-task=1   # How many cpus are we going to use
#SBATCH --qos=xlong  # priority of the execution. The major priority the fastest it will be executed. The priority must be changed according to the computational time

module load Python/Python-3.10.9-Anaconda3-2023.03-1
module load CUDA
module load GCC/13.2.0

ENV_PYTHON=/scratch/username/environmentExample/bin
$ENV_PYTHON/python my_program.py --args1 param1 --args2 param2
