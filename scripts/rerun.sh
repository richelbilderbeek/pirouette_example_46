#!/bin/bash
#
# Re-run the code locally, to re-create the data and figure.
#
# Usage:
#
#   ./scripts/rerun.sh
#
#SBATCH --partition=gelifes
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=10G
#SBATCH --job-name=pirex46
#SBATCH --output=example_46.log
#
rm -rf example_46
rm errors.png
time Rscript example_46.R
zip -r pirouette_example_46.zip example_46 example_46.R scripts errors.png

