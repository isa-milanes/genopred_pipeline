# GenoPred_pipeline
GenoPred Pipeline

Best resource for questions about the pipeline: https://opain.github.io/GenoPred/pipeline_readme.html#Video_tutorials

#### Organizing your data 

1. Download this repository (in HPC) which will include template files with the folders and files you will need.
   ```bash
   git clone https://github.com/isabella-milanes_yale/genopred_pipeline.git
   ```
2. Update ~new_data/target, you should have all of your imputed plink files in here
3. Update ~new_data/reference/gwas_sumstats, you should have your gwas_sumstats here
4. IF USING SCORE FILES, update ~new_data/reference/score_files, you should have your reference score files here, IF NOT USING, no need to update
5. Update ~new_input/config.yaml
   - change the 'score_list' location if one is included, if not NA
   - change the 'pgs_methods' include the wanted pgs methods (I suggest if you are running for the first time to use dbslmm and ptclump instead of prscs because it takes at least 6 hours)
   - change the 'outdir' path to where you want the output to go in your folders
   - change the 'ancestry_prob_thresh' to the cutoff you want for ancestry
   - change 'resdir' to the directory where you want the genopred_resources downloaded
  Explained in detail here: (https://opain.github.io/GenoPred/pipeline_readme.html#configfile)
7. Update gwas_list.txt
   - Required terms: given name, path to gwas sumstat, population of most of your dataset, n size
   - If phenotype is binary, you will need to include sampling and prevalence of the phenotype in the general population 
   - If phenotype is continuous, you will need to include mean in the general population and sd in the general population
  Explained in detail here: (https://opain.github.io/GenoPred/pipeline_readme.html#gwas_list)
8. Update target_list.txt
   - change name, path, type, and indiv_report
       - Notes about type: the options are outlined in the pipeline instructions but if using (.bed/.bim/.fam) plink files use plink1
       - Notes about indiv_report: (T/F) this creates an html report for each individual. If your dataset is big, it can take longer
  Explained in detail here: (https://opain.github.io/GenoPred/pipeline_readme.html#target_list)

#### Running the pipeline

1. Go into mccleary and allocate space
   ```bash
   salloc -p ycga --time=10:00:00 --mem-per-cpu=32G
   ```
2. Download the container in the directory where you downloaded this repo
   ```bash
   apptainer pull docker://opaino/genopred_pipeline:latest
   ```
   * this will create a .sif file
3. Update the symlinks in the genopred_outputall.sh script to where your data is located.
4. Run one of the pipeline batch scripts. Each one stops the pipeline to output only what you need.
   - genopred_outputall: runs the entire pipeline and all outputs
   ```bash
   sbatch genopred_outputall.sh
   ```
   Other batch scripts are named based on what they will output
  * you can modify any one of these by looking at the outputs in the picture below outlined in red and modify the 'snakemake -j8 --use-conda output_all --configfile=new_input/config.yaml' line in the code.
  * Once you have determined what outputs you would like, copy the key after --use-conda flag
![image](https://github.com/user-attachments/assets/fead6234-24a6-4147-82a2-80018bdf0c0a)


  
