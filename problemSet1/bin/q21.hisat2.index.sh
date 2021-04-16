# aedavids@ucsc.ed
# nohup q21.hisat2.index.sh 2>&1 > q21.hisat2.index.sh.`date "+%Y-%m-%d-%H.%M.%S-%Z%n"`.out &

set -x

module load hisat/hisat2-2.1.0

hisat2BaseName=hisat2.GRCh37.p13.genome
# -p number of threads
hisat2-build -p 12 data/GRCh37.p13.genome.fa $hisat2BaseName
