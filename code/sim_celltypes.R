#' Estimate splatPop parameters and generate summary plots for 
#' TENxPBMCData pbmc8k as a reference

suppressPackageStartupMessages({
  library(TENxPBMCData)
  library(splatter)
  library(VariantAnnotation)
  library(org.Hs.eg.db)
  library(tidyverse)
  library(scater)
  library(celldex)
  library(SingleR)
  library(RColorBrewer)
  library(ggpubr)
})

source("/mnt/beegfs/mccarthy/scratch/general/cazodi/Projects/KEJP_2020_splatPop/code/plot_functions.R")

# Annotate 10x PBMC data
ref <- BlueprintEncodeData()
pbmc <- TENxPBMCData(dataset = "pbmc8k")   # snapshotDate(): 2020-10-27
pbmc <- logNormCounts(pbmc)
pbmc <- runPCA(pbmc)
pbmc <- runUMAP(pbmc)

rowData(pbmc)$Symbol <- mapIds(org.Hs.eg.db, keys=rownames(pbmc), 
                   column="SYMBOL", keytype="ENSEMBL")

pbmc <- pbmc[!is.na(rowData(pbmc)$Symbol), ]
rownames(pbmc) <- rowData(pbmc)$Symbol

pred <- SingleR(test=pbmc, ref=ref, labels=ref$label.main)

colData(pbmc) <- cbind(colData(pbmc), pred)
pbmc$pruned.labels <- as.factor(pbmc$pruned.labels)

# 

plotPCA(pbmc, colour_by="pruned.labels")
ggsave("output/00_Figures/pbmc8_reference/PCA.pdf", height = 5, width = 5)
plotUMAP(pbmc, colour_by="pruned.labels")
ggsave("output/00_Figures/pbmc8_reference/UMAP.pdf", height = 5, width = 5)
plotVarExp1(pbmc, variables = c("pruned.labels"))
ggsave("output/00_Figures/pbmc8_reference/varExplained.pdf", height = 5, width = 5)
plotSilhouette(pbmc, pbmc, variables = c("pruned.labels"))
ggsave("output/00_Figures/pbmc8_reference/silhouette.pdf", height = 5, width = 5)
