
# Pull chr 1 tests from GTEx v8 summary statistics and move to project directory
GTEx=/mnt/mcfiles/Datasets/GTEx/GTEx_Analysis_v8_eQTL/
proj=/mnt/beegfs/mccarthy/backed_up/general/cazodi/Projects/WEEO_2021_meta-eQTL/data/

for f in "$GTEx"*.v8.signif_variant_gene_pairs.txt.gz; do zcat "$f" | grep -E  "^variant_id|^chr1_" > "$f"_chr1.txt; done
mv "$GTEx"*_chr1.txt "$proj".
