
# Pull chr 1 tests from GTEx v8 summary statistics and move to project directory
GTEx=/mnt/mcfiles/Datasets/GTEx/GTEx_Analysis_v8_eQTL_all_associations/
proj=/mnt/beegfs/mccarthy/backed_up/general/cazodi/Projects/WEEO_2021_meta-eQTL/data/

for f in "$GTEx"*.txt.gz; do zcat "$f" | grep -E  "^gene_id|chr1_" > "$f"_alltests_chr1.txt; done
mv "$GTEx"*_alltests_chr1.txt "$proj".
