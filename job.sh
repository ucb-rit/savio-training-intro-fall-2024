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
module load anaconda3/2024.02-1-11.4
python calc.py >& calc.out
