
# aedavids@ucsc.edu
# this take a long time to run
# use nohup
# nohup q21.star.index.sh 2>&1 > q21.star.index.sh.`date "+%Y-%m-%d-%H.%M.%S-%Z%n"`.out &
set -x

module load star

cd /hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1
mkdir -p mkdir data/STAR_GRCh37.p13.genome

STAR --runMode genomeGenerate \
    runThreadN 10 \
    --genomeDir        data/STAR_GRCh37.p13.genome/ \
    --genomeFastaFiles data/GRCh37.p13.genome.fa \
    --sjdbGTFfile      data/gencode.v37.annotation.gtf \
    --sjdbOverhang 75 

