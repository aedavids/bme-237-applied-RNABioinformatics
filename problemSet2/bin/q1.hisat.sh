#!/bin/bash
#SBATCH -p Instruction #128×24 # max nodes = 3, Intel nodes 128GBs / 2 x 12 cores# Instruction   # Partition name
#SBATCH -J ps2.q1        # Job name
#SBATCH --mail-user=aedavids@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH -o job%.j.q1.sh.out    # Name of stdout output file
#SBATCH -N 2        # Total number of nodes requested (128x24/Instructional only)
#SBATCH -n 16        # Total number of mpi tasks requested per node
#SBATCH -t 04:00:00  # Run Time (hh:mm:ss) - 4 hours (optional)
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

set -x
module load hisat/hisat2-2.1.0

module load samtools/samtools-1.10

# reference files
gtf=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/data/gencode.v37.annotation.gtf
hisat2IdxDir=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/data/hisat2.GRCh38.index
hisat2Idx="${hisat2IdxDir}/GRCh38.p13.genome"
spliceSites=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/data/hisat2.splicesites.txt

rootReadDir=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet2/data/reads


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
	hisat2Out="hisat2.GRCh38.${accession}.sam"
	sortedSamOut=`echo $hisat2Out | sed -e 's/\.sam/\.sorted.sam/' `

	if [ ! -f $hisat2Out ]; then
	    hisat2 -p 12 \
			-x $hisat2Idx \
			-1 $f1  \
			-2 $f2 \
			-S $hisat2Out \
			--known-splicesite-infile $spliceSites

	    # make sure we recompute sorted sam file
	    'rm' $sortedSamOut
	else 
	    echo skipping $hisat2Out it already exists
	fi


	# htseq-count reqires paired reads to be sort
	if [ -f $hisat2Out -a ! -f $sortedSamOut ]; then
	    samtools sort \
		-@ 10 \
		--output-fmt SAM \
		-o $sortedSamOut \
		$hisat2Out
		
	else
	    echo skipping $sortedSamOut it already exists or $hisat2Out is missing
	fi

       
	htseqCountOut="htseq-count.GRCh38.${accession}.out"
	if [ -f $sortedSamOut -a ! -f $htseqCountOut ]; then
	    # htseq-count requires paired reads to be sorted
	    htseq-count \
		-r pos \
		$sortedSamOut \
		$gtf \
		> $htseqCountOut
		
	else
	    echo skipping $htseqCountOut it already exists or $sortedSamOut is missing
	fi

    done
done

