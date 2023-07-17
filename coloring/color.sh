#!/bin/bash

#SBATCH -o color_results.txt
#SBATCH --nodes=1 # Number of node
#SBATCH --ntasks=1 # Number of tasks
#SBATCH --cpus-per-task=32 # How many threads to assign
#SBATCH --mem=32G # Hom much memory 

# Initialize the module command first source
source /etc/profile

# Load Julia Module
# Find out the list of modules available by running the command
#  module avail
module load julia/1.5.2

# Call your script as you would from the command line
julia color.jl


# RUN ON SUPERCLOUD RAH
