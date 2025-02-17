#!/bin/bash
#SBATCH --job-name=genopred_pipeline      # Job name
#SBATCH --output=genopred_pipeline.out    # Standard output log
#SBATCH --error=genopred_pipeline.err     # Error log
#SBATCH --time=23:59:00                   # Time limit hh:mm:ss
#SBATCH --partition=ycga                  # Partition (adjust as needed)
#SBATCH --cpus-per-task=8                 # Number of CPU cores
#SBATCH --mem=32G                         # Memory pool for all cores
#SBATCH --mail-type=ALL                   # Email on job BEGIN, END, FAIL

# Load necessary modules (skip if Apptainer is not a module)
module --ignore_cache load apptainer || echo "Apptainer module not found, proceeding if installed manually."

# Run the entire script inside Apptainer
apptainer exec --writable-tmpfs genopred_pipeline_latest.sif /bin/bash -c "
source /opt/mambaforge/etc/profile.d/conda.sh
conda activate genopred

# Navigate to the pipeline directory
cd /tools/GenoPred/pipeline

# Create symbolic links (only if they don’t already exist)
[ ! -L ./new_data ] && ln -s /vast/palmer/scratch/olfson/im433/prs_test2/new_data ./new_data
[ ! -L ./new_input ] && ln -s /vast/palmer/scratch/olfson/im433/prs_test2/new_input ./new_input

# Run Snakemake with 8 cores and Conda support
snakemake -j8 --use-conda output_all --configfile=new_input/config.yaml
"

