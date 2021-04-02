

```
$ module load hisat/hisat2-2.1.0
$ export HISAT2_HOME=/hb/software/apps/hisat2/gnu-2.1.0
[aedavids@hb ~]$ $HISAT2_HOME/hisat2 -f -x $HISAT2_HOME/example/index/22_20-21M_snp -1 $HISAT2_HOME/example/reads/reads_1.fa -2 $HISAT2_HOME/example/reads/reads_2.fa -S eg2.sam
1000 reads; of these:
  1000 (100.00%) were paired; of these:
    0 (0.00%) aligned concordantly 0 times
    1000 (100.00%) aligned concordantly exactly 1 time
    0 (0.00%) aligned concordantly >1 times
    ----
    0 pairs aligned concordantly 0 times; of these:
      0 (0.00%) aligned discordantly 1 time
    ----
    0 pairs aligned 0 times concordantly or discordantly; of these:
      0 mates make up the pairs; of these:
        0 (0.00%) aligned 0 times
        0 (0.00%) aligned exactly 1 time
        0 (0.00%) aligned >1 times
100.00% overall alignment rate
[aedavids@hb ~]$ 

```

## question 5

Download the GENCODE v37 human gene annotation and genome reference
```
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_37/gencode.v37.annotation.gtf.gz

wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_37/GRCh38.p13.genome.fa.gz
```

Use the ENCODE data portal (https://www.encodeproject.org (Links to an external site.)) to find the FASTQ files from mRNA sequencing of lung fibroblast primary cells. This was a paired-end library with 76bp reads. Download the data corresponding to biological replicate 1, i.e., accessions: ENCFF000IJA (read 1) and ENCFF000IJH (read 2).

[https://www.encodeproject.org/files/ENCFF000IJA/](https://www.encodeproject.org/files/ENCFF000IJA/)

[https://www.encodeproject.org/files/ENCFF000IJH/](https://www.encodeproject.org/files/ENCFF000IJH/)
```
wget https://www.encodeproject.org/files/ENCFF000IJA/@@download/ENCFF000IJA.fastq.gz

wget https://www.encodeproject.org/files/ENCFF000IJH/@@download/ENCFF000IJH.fastq.gz
```
