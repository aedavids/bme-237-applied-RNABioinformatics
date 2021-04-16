set -x

# the script does not work library issue
# scriptName=$0
# pyVersion=/hb/home/anbrooks/junction_bed_example/python/anaconda2/bin/python
# pyScript=/hb/home/anbrooks/junction_bed_example/preProcess_getASEventReadCounts.py
# samFile=/hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/data/hisat2.ENCFF000IJ.sam

# # Explanation of options:
# # -s: SAM file
# # -n: prefix for output files. One of them will be a BED file of junctions
# # -l: Length of reads in SAM/BAM file
# # -c: 0 (should be set to zero. A value above 0 will filter junctions in the alignment)
# # -o: Directory of output files
# #

# $pyVersion $pyScript -s $samFile -n test -l 36 -c 0 -o ./ 

# Other alternative approaches can be found here:
# https://www.biostars.org/p/240537/

# install featureCount
# http://bioinf.wehi.edu.au/subread-package/
wget https://sourceforge.net/projects/subread/files/subread-2.0.2/subread-2.0.2-Linux-x86_64.tar.gz/download

# -J (juncCounts)
# -p isPairedEnd
# -o output file
# -a annotation in gtf format
$d/featureCounts -J -p -o hisat2.ENCFF000IJ.junctions -a data/gencode.v37.annotation.gtf.gz data/hisat2.ENCFF000IJ.sam 

$ cut -f 6 hisat2.ENCFF000IJ.junctions.jcounts | sort | uniq -c | wc -l

