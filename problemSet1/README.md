# BME 237: Applied RNA Bioinformatics problem set 1
- April 2021
- Andrew Davidson aedavids@ucsc.edu
- Mays Salih      mmohamm7@ucsc.edu
- Sree Maroli     svelandi@ucsc.edu


General notes:
we compare two 'splice aligners', hisat2 and STAR. there are other types of aligners 'clip aligners' and 'psudo aligners. salmon and kalisto are psudo aliners

we are also comparing counters. that is to say featureCounts and HTSeq. Star can also do counting

## great reference
[UC Davis Bioinformatics Core August 2019 RNA-Seq Workshop @ UCD](https://ucdavis-bioinformatics-training.github.io/2019_August_UCD_mRNAseq_Workshop/cli/command-line-intro)
# load some useful tools.
You need to run the module load command everytime you log into humming bird

```
# list avalible moduels
module avail

module load hisat/hisat2-2.1.0
module load star
module load samtools/samtools-1.10
```

# question 1
Please enter the name of your partner(s):

# question 2
Using R

Use the ToothGrowth R (Links to an external site.) dataset and the ggplot2 package to create a violin plot comparing the tooth lengths of guinea pigs given orange juice (OJ) versus ascorbic acid (VC). Include individual points using geom_jitter. Examples using a different dataset can be found here: https://ggplot2.tidyverse.org/reference/geom_violin.html (Links to an external site.)


see ~/googleUCSC/bme-237-appliedRNABioinformatics/homework/problemSet1/r

# question 3
Accessing Hummingbird

3.1) Use the "ls" command to list the files in the directory
/hb/home/anbrooks/bme237_21SP/ 

3.2) How many files are in the directory? 
2

3.3) How many sub-directories are in the directory? 
1

3.4) Read the contents of the README file. What does it say? Hint: You can try the commands "more" or "less". 
Hello BME 237! Hope you have a great quarter!

# question 4

http://daehwankimlab.github.io/hisat2/manual/ search for 'Paired-end example'

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

## Data for problem set

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


# Question 5 
You generated an RNA-Seq library from polyA-selected RNA from HeLa cells. You sequenced 50 million paired-end 50bp reads, using an unstranded protocol. You used HISAT for the alignment and were able to map 40 million read pairs. What is the FPKM for the gene DUSP1 if the number of mapped read pairs was 1,000? Use the GENCODE v37 reference for your gene annotation.  Round to two decimal places.

https://www.rna-seqblog.com/rpkm-fpkm-and-tpm-clearly-explained/

1. not easy to find answer on UCSC genome browser
You have count all the exon lengths. not easy. Go to ucsc genome browser. select humand, gencode v37, DUSP1
    - https://genome.ucsc.edu/cgi-bin/hgTracks?hgsid=1080218607_CiLAyIbO8OAZW7D2Gl3QdGffxtPB&org=Human&db=hg19&position=DUSP1&pix=1025
    - https://genome.ucsc.edu/cgi-bin/hgTracks?db=hg19&lastVirtModeType=default&lastVirtModeExtraState=&virtModeType=default&virtMode=0&nonVirtPosition=&position=chr5%3A172195093%2D172198203&hgsid=1080218607_CiLAyIbO8OAZW7D2Gl3QdGffxtPB

2. next I clicked on the last exon. it on the left side. It takes you to 
   -https://genome.ucsc.edu/cgi-bin/hgGene?hgg_gene=uc003mbu.2&hgg_prot=uc003mbu.2&hgg_chrom=chr5&hgg_start=172195092&hgg_end=172197634&hgg_type=knownGene&db=hg19&hgsid=1080218607_CiLAyIbO8OAZW7D2Gl3QdGffxtPB

3. transcript size is 2,542

FPKM = 1000 / 40,000,000 / 2542 = 9.83477576711251e-09

# question 6
Some RNA-Seq analysis approaches involve aligning reads directly to spliced annotated transcript sequences, instead of against the genome. You decide to try this approach, particularly since you don’t care about unannotated alternative splicing events and are only interested in gene expression quantification.

Give 2 reasons why the above would be beneficial.
```
1) much easier computational problem to solve because you do not need to consider intronic regions

2) should run faster and require less memory

3) output from salmon is easy to use

4) we do not have to use another program like featureCounts or HTSeq to get the count values

5) disadvantage no information about junctions
```

# question 7
Give 2 reasons why the above may not be ideal.

```
1)  novel transcripts will not map

2) different annotations may have different exons. So you need to decide which annotation will work best for your data

3) disadvantage no information about junctions
```

# question 8
For the following RNA-Seq alignments with STAR and HISAT2, indicate which version of the software you used.

```
aedavids@hb problemSet1]$ hisat2 --version

/hb/software/apps/hisat2/gnu-2.1.0/hisat2-align-s version 2.1.0

64-bit

Built on login-node03

Wed Jun  7 15:53:42 EDT 2017

Compiler: gcc version 4.8.2 (GCC)

Options: -O3 -m64 -msse2 -funroll-loops -g3 -DPOPCNT_CAPABILITY

Sizeof {int, long, long long, void*, size_t, off_t}: {4, 8, 8, 8, 8, 8}


[aedavids@hb ~]$ STAR --version

STAR_2.5.3a
```

# question 9

Align the FASTQ files with STAR and HISAT2. 


## hisat2 commands
- http://daehwankimlab.github.io/hisat2/manual/
- https://wikis.utexas.edu/display/bioiteam/Mapping+with+HISAT2
 
step 1 ) unzip the reference genome
```
[aedavids@hb data]$ gunzip GRCh38.p13.genome.fa.gz
```

step 2) build index
```
time hisat2-build GRCh38.p13.genome.fa GRCh38.p13.genome
Total time for call to driver() for forward index: 01:24:35

real  84m35.078s
user  83m3.191s
sys   1m27.286s
```

The index is stored in the files ending with *.ht2
```
[aedavids@hb data]$ ls -1 GR*
GRCh38.p13.genome.1.ht2
GRCh38.p13.genome.2.ht2
GRCh38.p13.genome.3.ht2
GRCh38.p13.genome.4.ht2
GRCh38.p13.genome.5.ht2
GRCh38.p13.genome.6.ht2
GRCh38.p13.genome.7.ht2
GRCh38.p13.genome.8.ht2
GRCh38.p13.genome.fa
```

step 3) create a list of known splice sites

```
[aedavids@hb data]$ hisat2_extract_splice_sites.py gencode.v37.annotation.gtf\
    > hisat2.splicesites.txt
```

step 4) run hisat aligner
* -x  The basename of the index for the reference genome. 
* -1 Comma-separated list of files containing mate 1s (filename usually includes _1), e.g. -1 flyA_1.fq,
* -2 Comma-separated list of files containing mate 2s (filename usually includes _2), e.g. -2 flyA_2.fq,
* -S fiel to wrie SAM alighment to, default is stdou
* --know-slicesite-infile

```
time hisat2 -p 6 -x data/hisat2.GRCh38.index/GRCh38.p13.genome \
    -1 data/ENCFF000IJA.fastq.gz  -2 data/ENCFF000IJH.fastq.gz \
    -S data/hisat2.ENCFF000IJ.sam \
    --known-splicesite-infile data/hisat2.splicesites.txt
    
120419626 reads; of these:
  120419626 (100.00%) were paired; of these:
    67170411 (55.78%) aligned concordantly 0 times
    30538142 (25.36%) aligned concordantly exactly 1 time
    22711073 (18.86%) aligned concordantly >1 times
    ----
    67170411 pairs aligned concordantly 0 times; of these:
      60712 (0.09%) aligned discordantly 1 time
    ----
    67109699 pairs aligned 0 times concordantly or discordantly; of these:
      134219398 mates make up the pairs; of these:
        130079308 (96.92%) aligned 0 times
        1985934 (1.48%) aligned exactly 1 time
        2154156 (1.60%) aligned >1 times
45.99% overall alignment rate

real   201m26.011s
user   185m30.376s
sys    4m11.919s    
```


## run STAR
- https://physiology.med.cornell.edu/faculty/skrabanek/lab/angsd/lecture_notes/STARmanual.pdf
- https://wikis.utexas.edu/display/bioiteam/Mapping+with+STAR
- https://hbctraining.github.io/Intro-to-rnaseq-hpc-O2/lessons/03_alignment.html

step 1) create star index. This takes a long time

--sjdbOverhang specifies the length of the genomic sequence around the annotated junction
to be used in constructing the splice junctions database. Ideally, this length should be equal
to the ReadLength-1, where ReadLength is the length of the reads. For instance, for Illumina
2x100b paired-end reads, the ideal value is 100-1=99. In case of reads of varying length, the
ideal value is max(ReadLength)-1.

```
$ mkdir data/STAR_genome

$ gunzip gencode.v37.annotation.gtf.gz

# STAR --runMode genomeGenerate runThreadN 10 --genomeDir data/STAR_genome/ \
    --genomeFastaFiles data/GRCh38.p13.genome.fa --sjdbGTFfile data/gencode.v37.annotation.gtf \
    --sjdbOverhang 75
```

step 2) run star aligner
```
time STAR --runThreadN 10 --genomeDir data/STAR_genome/ \
    --outFileNamePrefix ENCFF000IJ.STAR  \
    --readFilesCommand zcat \
    --readFilesIn data/ENCFF000IJA.fastq.gz data/ENCFF000IJH.fastq.gz 
    
Apr 08 09:49:44 ..... started STAR run
Apr 08 09:49:45 ..... loading genome
Apr 08 09:50:12 ..... started mapping
Apr 08 10:27:47 ..... finished successfully

real   38m3.707s
user   354m28.864s
sys    13m37.478s

$ mv ENCFF000IJ.STAR* tmp
$ mv tmp ENCFF000IJ.STAR.out
```

# Question 10 how many uniq junctions?

Angela' python script does not work use alternative approaches can be found here:

- https://www.biostars.org/p/240537/
- http://bioinf.wehi.edu.au/featureCounts/
- http://bioinf.wehi.edu.au/subread-package/SubreadUsersGuide.pdf
- https://hbctraining.github.io/Intro-to-rnaseq-hpc-O2/lessons/05_counting_reads.html

count hisat2
```
$ echo $d
/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/bin/subread-2.0.2-Linux-x86_64/bin

$ pwd
/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/featureCounts.out

$ time $d/featureCounts -T 10 -J -p -o hisat2.ENCFF000IJ.junctions -a ../data/gencode.v37.annotation.gtf ../data/hisat2.ENCFF000IJ.sam 

|                                                                            ||
||             Input files : 1 SAM file                                       ||
||                                                                            ||
||                           hisat2.ENCFF000IJ.sam                            ||
||                                                                            ||
||             Output file : hisat2.ENCFF000IJ.junctions                      ||
||                 Summary : hisat2.ENCFF000IJ.junctions.summary              ||
||              Paired-end : yes                                              ||
||        Count read pairs : no                                               ||
||              Annotation : gencode.v37.annotation.gtf (GTF)                 ||
||      Dir for temp files : ./                                               ||
||       Junction Counting : <output_file>.jcounts       

||    Features : 1460986                                                      ||
||    Meta-features : 60651                                                   ||
||    Chromosomes/contigs : 25                                                ||
||                                                                            ||
|| Process SAM file hisat2.ENCFF000IJ.sam...                                  ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 403289896                                            ||
||    Successfully assigned alignments : 46783400 (11.6%)                     ||
||    Running time : 2.39 minutes                                             ||
||                                                                            ||
|| Write the final count table.                                               ||
|| Write the junction count table.                                            ||
|| Write the read assignment summary.                                         ||
||                                                                            ||
|| Summary of counting results can be found in file "hisat2.ENCFF000IJ.junct  ||
|| ions.summary"                                                              ||
||                                                                            ||
\\============================================================================//


real	2m32.421s
user	14m27.803s
sys	1m32.674s

```

count star
```
$ pwd
/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/featureCounts.out

time $d/featureCounts -T 10 -J -p -o star.ENCFF000IJ.junctions -a ../data/gencode.v37.annotation.gtf ../ENCFF000IJ.STAR.out/ENCFF000IJ.STAR.Aligned.out.sam

|| Load annotation file gencode.v37.annotation.gtf ...                        ||
||    Features : 1460986                                                      ||
||    Meta-features : 60651                                                   ||
||    Chromosomes/contigs : 25                                                ||
||                                                                            ||
|| Process SAM file ENCFF000IJ.STAR.Aligned.out.sam...                        ||
||    Paired-end reads are included.                                          ||
||    The reads are assigned on the single-end mode.                          ||
||    Total alignments : 549697188                                            ||
||    Successfully assigned alignments : 48571206 (8.8%)                      ||
||    Running time : 4.04 minutes       

real	4m11.409s
user	19m58.336s
sys	2m29.638s
```

how man unique junctions?
```
$ wc -l star.ENCFF000IJ.junctions.jcounts
92628 star.ENCFF000IJ.junctions.jcounts

$ wc -l hisat2.ENCFF000IJ.junctions.jcounts 
115345 hisat2.ENCFF000IJ.junctions.jcounts

```



# question 11

Find a splice junction that was detected by STAR, but not detected by HISAT2.

What is the chromosome, start position, and end position of the intron that corresponds to this splice junction?


```
# data files
starJunctions   = "featureCounts.out/star.ENCFF000IJ.junctions"
hisat2Junctions = "featureCounts.out/hisat2.ENCFF000IJ.junctions"

# see see RNA-bioinformatics-problemSet1.ipynb for full listing
starOnlyDF.loc[ starOnlyDF["s-Geneid"] == "ENSG00000284740.1", 
    ["s-Geneid", "s-Chr", "s-Start", "s-End", "s-Length"] ]
    
ENSG00000284740.1	chr1;chr1;chr1;chr1	1503250;1503582;1509205;1509205	1503661;1503661;1509452;1509351	660
```

# question 12 
How many reads were aligned to the above junction?

```
samtools view ENCFF000IJ.STAR.Aligned.out.sorted.bam chr1:1503250-1509351 | wc -l
15
```


# question 13
For each read (up to 3 reads) that aligned to the junction in STAR, what was the resulting alignment of these reads using HISAT2? Indicate the chromosome, start position, and CIGAR string for the alignments, if applicable.

```
samtools view ENCFF000IJ.STAR.Aligned.out.sorted.bam chr1:1503250-1509351 | head -n 3
PRESLEY_0023_FC61FLEAAXX:7:38:10174:12282#0	355	chr1	1373148	3	10M188889N66M	=	1562185	189112	TCTGGGACAATGGGCTCAGCTCCTTCTTTTAGAATGACCAGAGACAGGCTCATCCTCTGCCTATACCAAGTCCTTC	hhhhhhhhhhhhfhhghhhhhhhhghhhhhghhhhhhhhhhhhhhhgfghhchhhfhgfhhhgfghghaddhgedh	NH:i:2	HI:i:2	AS:i:147	nM:i:0
PRESLEY_0023_FC61FLEAAXX:7:1:6571:19856#0	99	chr1	1446334	255	43M142724N33M	=	1590539	144281	CGGAGGCCGAGGCAGGAGAATCACTTGAACCCAGGAGGTGGAGGTTGCAGTGAGCCAAGATCACACCACTGCACTC	hhhhhhh_fghhhhhhhhhhhhhhhhhhhhhgfhchhhdhfhhhdhefhaghhghghfhhcfhhhghfhhgggffh	NH:i:1	HI:i:1	AS:i:132	nM:i:8
PRESLEY_0023_FC61FLEAAXX:5:65:16719:9263#0	355	chr1	1465456	3	10M270468N66M	=	1736062	270682	CGGCAGGTGCAGCAGCTCACGCCTGGAATCCCAGCACTGTGGGGAGCTGAGGCGGGAAGATCACGAGGTCAGGAGC	gggggggegggggggggfagggggcgdgggggcgdgggfffffc`ggggdgddgfe\dededdgdddcaa_ca_ca	NH:i:2	HI:i:2	AS:i:147	nM:i:0

```

# question 14
- http://www.broadinstitute.org/igv/
- downloaded igv desktop. (this is was Alexis uses)
- web app intro video tutorial https://www.youtube.com/watch?v=sFeK-25K5PE
- tutorial video https://www.youtube.com/channel/UCb5W5WqauDOwubZHb-IA_rA
- use web app https://igv.org/app/
- https://davetang.org/wiki/tiki-index.php?page=SAMTools#Creating_a_BAM_index_file

ivg reqiures bam format
```
samtools view -S -b ./ENCFF000IJ.STAR.out/ENCFF000IJ.STAR.Aligned.out.sam > \
        ./ENCFF000IJ.STAR.out/ENCFF000IJ.STAR.Aligned.out.bam
```

need to sort
```
# -o write to file
# -@ number of threads
samtools sort ./ENCFF000IJ.STAR.out/ENCFF000IJ.STAR.Aligned.out.bam \
    -@ 10 \
    -o ./ENCFF000IJ.STAR.out/ENCFF000IJ.STAR.Aligned.out.sorted.bam
```

need to create a bam index file. ivg will look for index file in the same directory as bam
```
samtools index ./ENCFF000IJ.STAR.out/ENCFF000IJ.STAR.Aligned.out.sorted.bam  \
    -@ 10  \
    ENCFF000IJ.STAR.out/ENCFF000IJ.STAR.Aligned.out.sorted.bai 
```

see bme-237-appliedRNABioinformatics/homework/problemSet1/img/aedavids-problemSet1-q14.png

# <span style="color:red"> question 15 </span>
AEDWIP

# questions 16
Find a splice junction that was detected by HISAT2, but not detected by STAR.

What is the chromosome, start position, and end position of the intron that corresponds to this splice junction?

We got back 6 tokens, this is because there are three rows matching site 1. I assume this means their are 3 different transcripts? that is to say iso forms? The counts for each row are 39, 5, 107. If this was a single transcript with several exons I would expect the counts to vary but be much closer to each other.

```
# see RNA-bioinformatics-problemSet1.ipynb
# data files
starJunctions   = "featureCounts.out/star.ENCFF000IJ.junctions"
hisat2Junctions = "featureCounts.out/hisat2.ENCFF000IJ.junctions"

selectHisat2OnlyRows = ( (hasReadsDF["h-count"] != 0) & (hasReadsDF["s-count"] == 0) )

hisat2OnlyDF = hasReadsDF.loc[ selectHisat2OnlyRows ]

hisat2OnlyDF.loc[:,["s-Geneid", "s-count",  "h-Geneid", "h-Length", "h-count",]].head()
	s-Geneid	s-count	h-Geneid	h-Length	h-count
9	ENSG00000238009.6	0	ENSG00000238009.6	3726	1
21	ENSG00000228463.10	0	ENSG00000228463.10	8224	2
34	ENSG00000225630.1	0	ENSG00000225630.1	1044	8
37	ENSG00000229344.1	0	ENSG00000229344.1	682	8
40	ENSG00000198744.5	0	ENSG00000198744.5	547	1

hisat2OnlyDF.loc[ hisat2OnlyDF["h-Geneid"] == "ENSG00000238009.6", ["h-Geneid", "h-Chr", "h-Start", "h-End", "h-Length"] ]

h-Geneid	h-Chr	h-Start	h-End	h-Length
9	ENSG00000238009.6	chr1;chr1;chr1;chr1;chr1;chr1;chr1;chr1;chr1;c...	89295;92091;92230;110953;112700;112700;112700;...	91629;92240;92240;111357;112804;112804;112804;...	3726
```


# questions 17
How many reads were aligned to this junction?

```
samtools view hisat2.ENCFF000IJ.sorted.bam chr1:89295-112804 | wc -l
25
```


#  question 18 
For each read (up to 3 reads) that aligned to the junction in HISAT2, what was the resulting alignment of these reads using STAR? Indicate the chromosome, start position, and CIGAR string for the alignments, if applicable.

```
samtools view hisat2.ENCFF000IJ.sorted.bam chr1:89295-112804 | head -n 3
PRESLEY_0023_FC61FLEAAXX:6:93:11255:12813#0	329	chr1	90913	1	76M	=	90913	0	GGTTCTTGGACCAGGTGCGGTGGCTCACATCTGTAATCCCAGCAATTTGGGAGGCCGAGGCGGGTGGATCACAAGG	gfgegggfggfffffafdfdffffffgggegggggfdfffcfffcfffdagggegfccfcffac]d]]bbgegggf	AS:i:0	ZS:i:0	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:76	YT:Z:UP	NH:i:3
PRESLEY_0023_FC61FLEAAXX:5:65:19368:1577#0	145	chr1	91431	60	3S73M	=	586009	0	CGATGGCAGCAGAGGTCAGCAATGCAAACCCGAGCCCAAGGATGCGGGGTGGGGGCAGGTACATCCTCTCTTGAGC	BBBBBBBBBBBBBBBBBBBBBBBBB_d`Q^bQ^_J^^^RR^\QMVUNKSRWY^Y[aaffbbcfWcfWcdedRW]df	AS:i:-14	XN:i:0	XM:i:2	XO:i:0	XG:i:0	NM:i:2	MD:Z:19G15G37	YT:Z:UP	NH:i:1
PRESLEY_0023_FC61FLEAAXX:5:52:9119:12896#0	355	chr1	96889	0	76M	=	407431	212959	CTGGGGGGAAATGAGTTTGGTTTCACTTAGTCTCTCTAAAGAGAAAGCAAGTCGGTGGACTAATACCTAATAAAAG	hhhhhhhhhfghfhhhhhhhhhhhhhhghghhhhhhfhhfhhhhhehcfhhhhchfhhhghhhhhghhhfhhgehh	AS:i:-12	ZS:i:-12	XN:i:0	XM:i:2	XO:i:0	XG:i:0	NM:i:2	MD:Z:5T50A19	YS:i:-6	YT:Z:CP	NH:i:3

```

# question 19 
aedavids-problemSet-1-q19.png

# <span style="color:red"> question 20</span>
AEDWIP

# question 21
Run HTSeq count for gene quantification using the STAR alignment BAM and then separately with the HISAT2 alignment BAM. Use GENCODE v19 as the genome reference.

HTSeq has 3 over lapping modes, union, interesection-stict, and intersection-nonempty. Assignment does not way which should use. I choose union

What version of HTSeq count did you use?

Written by Simon Anders (sanders@fs.tum.de), European Molecular Biology
Laboratory (EMBL). (c) 2010. Released under the terms of the GNU General
Public License v3. Part of the 'HTSeq' framework, version 0.11.0.

# question 22
What were the exact commands you ran?

load useful tools
```
module avail
module load samtools/samtools-1.10
module load star
module load hisat/hisat2-2.1.0
```

download
```
cd data

# https://www.gencodegenes.org/human/release_19.html
# content" comprehensive gene annnotation, region CHR
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_19/gencode.v19.annotation.gtf.gz

# Genome sequence (GRCh37.p13); all
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_19/GRCh37.p13.genome.fa.gz
gunzip GRCh37.p13.genome.fa.gz
```

create index
```
nohup ./bin/q21.star.index.sh 2>&1 > q21.star.index.sh.`date "+%Y-%m-%d-%H.%M.%S-%Z%n"`.out &
nohup bin/q21.hisat2.index.sh 2>&1 > q21.hisat2.index.sh.`date "+%Y-%m-%d-%H.%M.%S-%Z%n"`.out & 
```

run alingers
```
nohup q21.star.align.sh   2>&1 > q21.star.align.sh.`date "+%Y-%m-%d-%H.%M.%S-%Z%n"`.out & 
nohup q21.hisat2.align.sh 2>&1 > q21.hisat2.align.sh.`date "+%Y-%m-%d-%H.%M.%S-%Z%n"`.out &
```

install htseq
```
# download htseq
#https://htseq.readthedocs.io/en/release_0.11.1/count.html
# not sure if we need to run pip or not
$ pip install HTSeq
$ which htseq-count
/hb/software/apps/python/gnu-3.6.2/bin/htseq-count
```

sort the alignmetns
```
# http://quinlanlab.org/tutorials/samtools/samtools.html
# htseq uses sam format. plus it will be easier to debug
# convert from sam to bam format
samtools view -S -b ./ENCFF000IJ.STAR_GRCh37.p13_STAR.out/ENCFF000IJ.STAR_GRCh37.p13Aligned.out.sam \
    > ./ENCFF000IJ.STAR_GRCh37.p13_STAR.out/ENCFF000IJ.STAR_GRCh37.p13Aligned.out.bam

samtools sort ./ENCFF000IJ.STAR_GRCh37.p13_STAR.out/ENCFF000IJ.STAR_GRCh37.p13Aligned.out.bam \
    --output-fmt SAM \
    -o ./ENCFF000IJ.STAR_GRCh37.p13_STAR.out/ENCFF000IJ.STAR_GRCh37.p13Aligned.out.sorted.sam
    
samtools view -S -b ./data/hisat2.GRCh37.p13.ENCFF000IJ.sam > ./data/hisat2.GRCh37.p13.ENCFF000IJ.bam

samtools sort ./data/hisat2.GRCh37.p13.ENCFF000IJ.bam  \
    --output-fmt SAM \
    -o ./data/hisat2.GRCh37.p13.ENCFF000IJ.sorted.sam
```

count 
```
# https://bioinformatics.uconn.edu/resources-and-events/tutorials-2/rna-seq-tutorial-with-reference-genome/#
# paired reads must be sorted. 
# -r ; paired data. sorted by pos; see doc if sorted by name
# default assume data is stranded
mkdir htseq-count.out

htseq-count -r pos \
    ./ENCFF000IJ.STAR_GRCh37.p13_STAR.out/ENCFF000IJ.STAR_GRCh37.p13Aligned.out.sorted.sam \
    ./data/gencode.v37.annotation.gtf \
    > ./htseq-count.out/htseq-count.ENCFF000IJ.STAR_GRCh37.p13Aligned.counts
    
htseq-count -r pos \
    ./data/hisat2.GRCh37.p13.ENCFF000IJ.sorted.sam \
    ./data/gencode.v37.annotation.gtf \
    > ./htseq-count.out/htseq-count.hisat2.GRCh37.p13.ENCFF000IJ.sorted.sam.counts
```

# <span style="color:red"> question 23</span>
Compare gene expression counts between STAR- and HISAT-based alignments by producing an x-y scatter plot. Submit a figure of your plot. Make sure that the axes are labeled

see 
- bme-237-appliedRNABioinformatics/homework/problemSet1/img/aedavids-problemSet1-q23.png
- notebooks/RNA-bioinformatics-problemSet1Q23-24.ipynb 

# <span style="color:red"> question 24</span>
Describe the resulting plot from above. How similar are the gene expression counts and what is your measure of similarity? If there are differences in the gene expression read counts between STAR and HISAT2 what are one or more possible causes?

Given the large range of the raw count data, I log scaled it for the plots.

Given the the large number of transcripts with non zero counts, I ploted a random sample of 10% of all transcripts. 

As a measure of similarty I calculated the RMSE, root mean squared error of the raw count values for transcripts with no-zero reads. We expect the number of transcript counts to be same between star and hisat 2. so the error measure ment of start - hisat is expected to be zero.

RMSE = 1/number of transcripts * sqrt( sum( (star - hisat)**2) )
RMSE: 14488.64

The RMSE was calculated for the 8079 transcript that had a count that was > 0 for at least one of the two alignement methods

The smaller the error distance the smaller RMSE is the more similar the results of the different methods are to each other. 

The difference between the counts has to do with how framents are handled. For example, union, vs interset, indels,  ...

Interesting notes about the plot there are some vertical lines and some horizontal lines. This suggests that there are some transcript where one method counted dramatically more fragments than the other. I wonder if there is something in common with these transcripts?

