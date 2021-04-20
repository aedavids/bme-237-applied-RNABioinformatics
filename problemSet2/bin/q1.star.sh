#!/bin/bash
#SBATCH -p 128x24 # no time limit
#SBATCH -J ps2.q1        # Job name
#SBATCH --mail-user=aedavids@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH -o q1.star.sh.out    # Name of stdout output file
#SBATCH -N 2        # Total number of nodes requested (128x24/Instructional only)
#SBATCH -n 16        # Total number of mpi tasks requested per node
#SBATCH -t infinite
#SBATCH --mem=64G # Memory to be allocated PER NODE


# ref: 
# https://support.ceci-hpc.be/doc/_contents/QuickStart/SubmittingJobs/SlurmTutorial.html
# Creating SBATCH Scripts for use with the job schedule https://www.hb.ucsc.edu/getting-started/
# partitions https://hummingbird.ucsc.edu/documentation/hummingbird-hardware-configurations/

#
# BME 237: Applied RNA Bioinformatics problem set 2 questions 1
# Andy Davidson
# aedavids@ucsc.edu
# april 2021
#

#
# we did not find the differentialy expressed genes reported in 
# Illumina MiSeq data from the Trapnell et al. Nature Biotechnology, 2013 paper using DESeq2. In
# this study, they used Cuffdiff2 to identify genes affected by knockdown of the HOXA1 transcription 
# factor in human primary lung fibroblasts. There are three biological replicates of a control
#  siRNA knockdown and three biological replicates of knockdown of HOXA1.
#
# The GEO accession number for the experiment is GSE37703.  The MiSeq data is paired-end 26 bp. 
#
# could this be because "Mays Mohammed Salih"
# Star is able to discover non-canonical splices and chimeric transcripts. The way it does that
#  is by aligning MMPs to the first exon match and keep going down exons until it finds
# the next match without the need to go back to the beginning. 
# It also aligns to sequences with less than perfect matching which allows for some flexibility.  
# This is an advantage over HISAT which requires matches of 28 or 8mers to extend. 
#

set -x
module load star
module load samtools/samtools-1.10

# reference files
# gtf=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/data/gencode.v37.annotation.gtf
# hisat2IdxDir=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/data/hisat2.GRCh38.index
# hisat2Idx="${hisat2IdxDir}/GRCh38.p13.genome"
# spliceSites=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/data/hisat2.splicesites.txt

rootReadDir=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet2/data/reads

#
# build the star index if it does not already exist
#
probSet1Data=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/data
probSet2Data=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet2/data
starIdxDir=${probSet2Data}/starIdx.GRCh38.p13.26bp
genomeFastaFiles=${probSet1Data}/hisat2.GRCh38.index/GRCh38.p13.genome.fa
gtf=${probSet1Data}/gencode.v37.annotation.gtf

if [ ! -d $starIdxDir ] ;
then
    mkdir -p $starIdxDir
    STAR --runMode genomeGenerate \
	runThreadN 20 \
	--genomeDir $starIdxDir \
	--genomeFastaFiles $genomeFastaFiles \
        --sjdbGTFfile $gtf \
	--sjdbOverhang 26

    existStatus=$?
    printf STAR genomeGenerate error status xxx $existStatus xxx
fi

replicates="controls HOXA1_KD"
for p in $replicates;
do
    cd "${rootReadDir}/${p}"

    for f1 in `ls *_1.fastq`;
    do
	printf "\n\n-----------------------\n"
	# echo SRR493373_1.fastq | sed -e 's/_1/_2/'
	f2=`echo $f1 | sed -e 's/_1/_2/' `
	accession=`echo $f1 | cut -f 1 -d '_' `
	prefix="star.GRCh38.26.bm.${accession}."
	bamOut="star.GRCh38.26.bm.${accession}.sorted.bam"


	if [ ! -f "${prefix}Aligned.out.bam" ]; then
	    STAR --runThreadN 10 \
		--outSAMtype BAM SortedByCoordinate \
		--genomeDir $starIdxDir \
		--outFileNamePrefix $prefix  \
		--readFilesCommand zcat \
		--readFilesIn $f1 $f2
	    
	    starExitStatus=$?
	    printf star exit status: $starExitStatus for $prefix

	else 
	    echo skipping $bamOut it already exists
	fi
       
	# aedwip htseqCountOut="htseq-count.GRCh38.${accession}.out"
	# if [ -f $sortedSamOut -a ! -f $htseqCountOut ]; then
	#     # htseq-count requires paired reads to be sorted
	#     echo htseq-count \
	# 	-r pos \
	# 	$sortedSamOut \
	# 	$gtf \
	# 	> $htseqCountOut
		
	# else
	#     echo skipping $htseqCountOut it already exists or $sortedSamOut is missing
	# fi

    done
done

