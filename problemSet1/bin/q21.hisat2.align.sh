# aedavids@ucsc.ed
# nohup q21.hisat2.align.sh 2>&1 > q21.hisat2.align.sh.`date "+%Y-%m-%d-%H.%M.%S-%Z%n"`.out &

set -x

module load hisat/hisat2-2.1.0

cd /hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1

spliceSites=data/hisat2.gencode.v37.annotation.splicesites.txt
hisat2_extract_splice_sites.py data/gencode.v37.annotation.gtf > $spliceSites

hisat2Dir=data/hisat2.GRCh37.p13.index
hisat2IndexPrefix=hisat2.GRCh37.p13.genome

hisat2 -p 12 \
    -x ${hisat2Dir}/${hisat2IndexPrefix} \
    -1 data/ENCFF000IJA.fastq.gz \
    -2 data/ENCFF000IJH.fastq.gz \
    -S data/hisat2.GRCh37.p13.ENCFF000IJ.sam \
    --known-splicesite-infile $spliceSites
