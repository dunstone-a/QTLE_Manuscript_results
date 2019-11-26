#!/bin/bash

# FUNCTION: Preprocess single cell data
# USAGE: sh sc_preprocess.sh </PATH/TO/RAW/FASTQ/FILES> </PATH/TO/OUTPUT>
# EXAMPLE: sc_preprocess.sh /mnt/mcscratch/cazodi/Datasets/sc_fibro/ 
#                           /mnt/mcfiles/cazodi/Projects/EUUI_2019_sceQTL-Workflow/output/00_sc-preprocessing/
# This script accepts the directory where raw fastq files are located and performs the following:
#		1. Read quality control (FastQC)
#		2. Summary of read quality control (MultiQC)
#		3. Quality and adaptor trimming (Trim_Galore!)
#		4. Trimmed read quality control (FastQC)
#		5. Summary of trimmed read quality control (MultiQC)

$WKDIR=/mnt/mcfiles/cazodi/Projects/EUUI_2019_sceQTL-Workflow/output/00_sc-preprocessing/

# Read input arguments
dir_in=$1
dir_out=$2
name=basename dir_in

dir_in
dir_out
name

# 1. Read quality control (FastQC)
 
## Fibro
#for i in ERR*fastq.gz; do fastqc -f fastq -out /mnt/mcfiles/cazodi/projects/01_sceQTL/00_ReadQC $i; done

## iPSC


# Trim_galore!

## Fibro

## iPSC


# FastQC on trimmed reads

## Fibro

## iPSC


# Salmon

## Fibro

## iPSC


# Scater

## Fibro

## iPSC


# Scran

## Fibro

## iPSC