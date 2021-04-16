#!/bin/bash

aedwip I think we do not want to use Instruction partion the limit is 4 hrs
we should 256x44 or 128x24, it is ?infinite?


#SBATCH -p Instruction   # Partition name
#SBATCH -J ps2.q1        # Job name
#SBATCH --mail-user=aedavids@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH -o job%.j.out    # Name of stdout output file
#SBATCH -N 2        # Total number of nodes requested (128x24/Instructional only)
#SBATCH -n 16        # Total number of mpi tasks requested per node
#SBATCH -t 04:00:00  # Run Time (hh:mm:ss) - 4 hours (optional)
#SBATCH --mem=64G # Memory to be allocated PER NODE


# ref: 
# https://support.ceci-hpc.be/doc/_contents/QuickStart/SubmittingJobs/SlurmTutorial.html
# Creating SBATCH Scripts for use with the job schedule https://www.hb.ucsc.edu/getting-started/


#
# BME 237: Applied RNA Bioinformatics problem set 2 questions 1
# Andy Davidson
# aedavids@ucsc.edu
# april 2021
#

set -x
module load hisat/hisat2-2.1.0


hisat2IdxDir=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/data/hisat2.GRCh38.index
spliceSites=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/data/hisat2.splicesites.txt

rootReadDir=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet2/data/reads

replicates="controls HOXA1_KD"
for p in $replicates;
do
    cd "${rootReadDir}/${p}"

    for f1 in `ls *_1.fastq`;
    do
	# echo SRR493373_1.fastq | sed -e 's/_1/_2/'
	f2=`echo $f1 |  | sed -e 's/_1/_2/' `
	accession=`echo $f1 | cut -f 1 -d '_' `
	echo hisat2 -p 12 \
		 -x data/hisat2.GRCh38.index/GRCh38.p13.genome \
		 -1 $f1  \
		 -2 $f2 \
		 -S "hisat2.GRCh38.${accession}.sam" \
		 --known-splicesite-infile $spliceSites
    done
done

/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet2/data/reads

controls/  HOXA1_KD/

.fastq
