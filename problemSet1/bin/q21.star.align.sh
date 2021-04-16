# aedavids@ucsc.edu
# use nohup
# nohup q21.star.align.sh 2>&1 > q21.star.align.sh.`date "+%Y-%m-%d-%H.%M.%S-%Z%n"`.out &
set -x

module load star

cd /hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1

STAR --runThreadN 10 \
    --genomeDir data/STAR_GRCh37.p13.genome/ \
    --outFileNamePrefix ENCFF000IJ.STAR_GRCh37.p13  \
    --readFilesCommand zcat \
    --readFilesIn data/ENCFF000IJA.fastq.gz data/ENCFF000IJH.fastq.gz 
