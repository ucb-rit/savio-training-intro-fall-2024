#!/bin/bash

# Job name:
#SBATCH --job-name=test
#
# Account:
#SBATCH --account=fc_paciorek
#
# Cores:
#SBATCH --cpus-per-task=4
#
# Partition:
#SBATCH --partition=savio3_htc
#
# Wall clock limit (5 minutes here):
#SBATCH --time=00:05:00
#
## Command(s) to run:
module load python/3.11.6-gcc-11.4.0
python calc.py >& calc.out
