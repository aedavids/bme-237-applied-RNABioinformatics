#set -x

this does not work. see  RNA-bioinformatics-problemSet1.ipynb 


pushd /hb/home/aedavids/bme-237-applied-RNABioinformatics/problemSet1/featureCounts.out

starSiteIds="starSiteIds.txt"
# use tail to remove the top 2 lines
# -n, --lines=K
#    output the last K lines, instead of the last 10; or use -n +K to output starting with the Kth
cut -f 3 star.ENCFF000IJ.junctions.jcounts | tail -n +2 > $starSiteIds

hisat2Ids="hisat2Side1Id.txt"
cut -f 3 hisat2.ENCFF000IJ.junctions.jcounts | tail -n +2 > $hisat2Ids

for i in `cat $starSiteIds`;
do
    grep $i $hisat2Ids > /dev/null
    found=$?

    if [ $found -ne 1 ];
    then
#	set -x
	echo Site_1: $i is in star but not histat2

	tokens=`grep $i star.ENCFF000IJ.junctions.jcounts | cut -f 4,7`
	echo tokens: $tokens
	grep $i $starSiteIds
	site1_location=$(echo $tokens | cut -f1 -d " ")
	site2_location=$(echo $tokens | cut -f2 -d " ")
	echo site1_location: $site1_location
	echo site2_location: $site2_location

	

	'rm' $starSiteIds $hisat2Ids
	exit 0
    fi
    
done

echo ERROR did not both have same site1_ 

exit 1
