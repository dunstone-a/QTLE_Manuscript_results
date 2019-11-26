#Methods for eQTL analysis from Single Cell RNA-Seq

##Data

###Install fast ENA bulk download software
####1. Download and install aspera:
```
wget https://download.asperasoft.com/download/sw/connect/3.9.7/ibm-aspera-connect-3.9.7.175481-linux-g2.12-64.tar.gz
tar zxvf ibm-aspera-connect-3.9.7.175481-linux-g2.12-64.tar.gz
./ibm-aspera-connect-3.9.7.175481-linux-g2.12-64.sh
```
####2. Get accessions to download and generate ascp run files
**Fibroblast data: https://www.ebi.ac.uk/ena/data/view/PRJEB28691
iPSC data: https://www.ebi.ac.uk/ena/data/view/PRJEB14362
genotype data: http://www.hipsci.org/lines/#/files (ENA: https://www.ebi.ac.uk/ena/data/view/PRJEB11750)**

**Firbroblast data (E-MTAB-7167 from the Cardelino paper (McCarthy et al)))**
1. Download text file from ENA

2. Convert to wget download file:
```awk 'FS="\t", OFS="\t" { gsub("ftp.sra.ebi.ac.uk", "ftp://ftp.sra.ebi.ac.uk"); print }' PRJEB28691.txt | cut -f5 | awk -F ";" 'OFS="\n" {print $1, $2}' | awk NF | awk 'NR > 1, OFS="\n" {print "/usr/bin/wget" " " $1}' > download.txt```

3. Run using tmux:
```
tmux new -s fibro  # Running on mc01
bash download.txt
```

4. Check downloads complete:
```
python /mnt/mcfiles/cazodi/github/Utilities/check_download.py -run download.txt -col 1 -delim '/' -sep ' '
```


**Downloading genotype data**
1. Download text file from ENA: Study accession, Analysis accession, Submitted files (FTP), Submitter's analysis name, Sample accession. 

2. Convert into bash run file:

```awk 'FS="\t", OFS="\t" { gsub("ftp.sra.ebi.ac.uk", "ftp://ftp.sra.ebi.ac.uk"); print }' PRJEB11750.txt | cut -f6 | awk -F ";" 'OFS="\n" {print $1, $2}' | awk NF | awk 'NR > 1, OFS="\n" {print "/usr/bin/wget" " " $1}' > download.txt```

3. Select only genotype files (i.e. .vcf) 
grep 'genotypes.vcf.gz' download.txt > download_vcf.txt



**iPSC data**
1. Download text file from ENA

2. Convert to wget download file:
```awk 'FS="\t", OFS="\t" { gsub("ftp.sra.ebi.ac.uk", "ftp://ftp.sra.ebi.ac.uk"); print }' PRJEB14362.txt | cut -f5 | awk -F ";" 'OFS="\n" {print $1, $2}' | awk NF | awk 'NR > 1, OFS="\n" {print "/usr/bin/wget" " " $1}' > download.txt```

3. Run using tmux:
```
tmux new -s fibro_ipsc  # Running on mc01
bash download.txt
```

4. Check downloads complete:
```
python /mnt/mcfiles/cazodi/github/Utilities/check_download.py -run download.txt -col 1 -delim '/' -sep ' '
```

*Trying with aspera... never got it to work... couldn't connect TCP for SSH:*
```
awk 'FS="\t", OFS="\t" { gsub("ftp.sra.ebi.ac.uk", "era-fasp@fasp.sra.ebi.ac.uk:"); print }' accessions.txt | cut -f3 | awk -F ";" 'OFS="\n" {print $1, $2}' | awk NF | awk 'NR > 1, OFS="\n" {print "$HOME/.aspera/connect/bin/ascp -QT -l 300m -P33001 -i $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh" " " $1 " ."}' > download.txt
```

##Data Pre-processing

### Read Quality Control using [FastQC](https://raw.githubusercontent.com/s-andrews/FastQC/master/INSTALL.txt)
```
conda install -c bioconda fastqc
for i in ERR*fastq.gz; do fastqc -f fastq -out /mnt/mcfiles/cazodi/projects/01_sceQTL/00_ReadQC $i; done
```

Merge FastQC results:
```
chmod +x /mnt/mcfiles/cazodi/github/Utilities/MultiQC.sh
/mnt/mcfiles/cazodi/github/Utilities/MultiQC.sh
```

### Trim reads using [TrimGalore!](https://github.com/FelixKrueger/TrimGalore/blob/master/Docs/Trim_Galore_User_Guide.md)
*Install*
```
fastqc -v  # dependency
cutadapt --version  # dependency
conda install -c bioconda cutadapt
curl -fsSL https://github.com/FelixKrueger/TrimGalore/archive/0.6.5.tar.gz -o trim_galore.tar.gz
tar xvzf trim_galore.tar.gz
~/TrimGalore-0.6.5/trim_galore
```








