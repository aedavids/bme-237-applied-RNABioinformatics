# aedavids@ucsc.ed
aedwip # nohup q21.hisat2.align.sh 2>&1 > q21.hisat2.align.sh.`date "+%Y-%m-%d-%H.%M.%S-%Z%n"`.out &
# ref: https://htseq.readthedocs.io/en/release_0.11.1/count.html

set -x

cd /hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1

# -r <order>, --order=<order>
# For paired-end data, the alignment have to be sorted either by read name or by alignment position. If your data is not sorted, use the samtools sort function of samtools to sort it. Use this option, with name or pos for <order> to indicate how the input data has been sorted. The default is name.

# histat alignemnt
htseq-count [options] <alignment files in sam format> data/gencode.v37.annotation.gtf

# star aligment
htseq-count [options] <alignment files in sam format> data/gencode.v37.annotation.gtf


