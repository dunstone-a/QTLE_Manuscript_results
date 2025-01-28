
# Pull chr 1 tests from GTEx v8 summary statistics and move to project directory
# Christina Azodi and Amelia Dunstone
# Updated 2025-01-22

# This script unzips the GTEx v8 data and copies the .txt files into the /data 
# folder of the project. 

# Prior to running this script, download data for the 10 cell types from Google Cloud.
# Link: https://console.cloud.google.com/storage/browser/gtex-resources/GTEx_Analysis_v8_QTLs/GTEx_Analysis_v8_eQTL_all_associations

# Cell-types: 
# Adipose_Subcutaneous, Lung, Thyroid, Artery_Tibial, Muscle_Skeletal, 
# Skin_Not_Sun_Exposed_Suprapubic, Whole_Blood, Esophagus_Mucosa, Nerve_Tibial, 
# Skin_Sun_Exposed_Lower_leg

# To run script, 'bash preprocess_gtex_alltests.sh'. 
# Approximately 1-2 minutes per file. Total time ~ 30 minutes.

# Update the lines below to point to the location of your data files and project.
GTEx=/mnt/beegfs/mccarthy/backed_up/old_mcfiles/Datasets/GTEx/GTEx_Analysis_v8_eQTL_all_associations/
proj=/mnt/beegfs/users/amelia.dunstone/Scratch/QTLE_Manuscript_results/data/

for f in "$GTEx"*.txt.gz; do zcat "$f" | grep -E  "^gene_id|chr1_" > "$f"_alltests_chr1.txt; done
mv "$GTEx"*_alltests_chr1.txt "$proj".
