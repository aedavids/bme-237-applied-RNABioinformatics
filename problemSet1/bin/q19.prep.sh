#!/bin/bash

aedwip I think we do not want to use Instruction partion the limit is 4 hrs
we should 256x44 or 128x24, it is ?infinite?


#SBATCH -p Instruction   # Partition name
#SBATCH -J q19.prep        # Job name
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

set -x
module load samtools/samtools-1.10

cd /hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1

# ivg reqiures bam format
samtools view -S -b ./data/hisat2.ENCFF000IJ.sam > \
        ./data/hisat2.ENCFF000IJ.bam


# need to sort
# -o write to file
# -@ number of threads
samtools sort ./data/hisat2.ENCFF000IJ.bam \
    -@ 10 \
    -o ./data/hisat2.ENCFF000IJ.sorted.bam


#need to create a bam index file. ivg will look for index file in the same directory as bam

# -o write to file
samtools index ./data/hisat2.ENCFF000IJ.sorted.bam \
    -@ 10 \
    ./data/hisat2.ENCFF000IJ.sorted.bai 
