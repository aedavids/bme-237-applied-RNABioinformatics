# Problem set 7 Mapping protein-RNA interactions
- aedavids@ucsc.edu
- bme-237 5/25/21

For this problem set, we will try to replicate part of a figure in the main paper from the ENCODE project describing the large eCLIP dataset and downstream analysis (Van Nostrand et al. Nature 2020 https://www.nature.com/articles/s41586-020-2077-3. In Figure 2a, they show the fraction of reproducible eCLIP peaks (irreproducible discovery rate, IDR < 0.01) that were found in different regions of pre-mRNA or non-coding RNAs for each of the RNA binding proteins examined. For this problem set, you will report the fraction of peaks in different regions bound by the proteins UPF1 and PTBP1. UPF1 is highlighted in the figure. PTBP1 is not highlighted in the figure.

You will first have to download the reproducible peaks for UPF1 and PTBP1 from the ENCODE Data Portal: https://www.encodeproject.org/ (Links to an external site.). We will only work with data from the K562 cell line.


The accession number for the UPF1 reproducible peaks is ENCFF597NVR.

The accession number for the PTBP1 reproducible peaks is ENCFF907HNN.


The files that you download are in bed narrowPeak formatLinks to an external site https://genome.ucsc.edu/FAQ/FAQformat.html#format12  This data is using the hg38 human genome reference.


https://www.encodeproject.org/files/ENCFF597NVR/
```
curl https://www.encodeproject.org/files/ENCFF597NVR/@@download/ENCFF597NVR.bed.gz -o ENCFF597NVR.bed.gz
```

https://www.encodeproject.org/files/ENCFF907HNN/
```
curl https://www.encodeproject.org/files/ENCFF907HNN/@@download/ENCFF907HNN.bed.gz -o  ENCFF907HNN.bed.gz
```

We will not look at all regions that were defined in the paper, for simplicity. Download the CDS, 3'UTR, 5'UTR, and intron regions from the GENCODE v36 (hg38 human genome reference) in BED format.

You can do this using the UCSC Genome Browser (genome.ucsc.edu). From the Genome Browser, go to "Tools-> Table Browser" from the top menu. Make sure that the following is selected from the menu:

group: Genes and Gene Predictions

track: GENCODE V36

table: knownGene

region: genome

output format: BED - browser extensible data

make sure you specify the name of an output file. e.g. aedwip.bed

Then click "get output".
 

In the next screen, you should see options to create one BED record per...

For CDS regions, select "Coding Exons". Save this in its own bed file.

For 3'UTR, select "3' UTR Exons". Save this in its own bed file.

For 5'UTR, select "5' UTR Exons". Save this in its own bed file.

For Introns, select "Introns plus 0 bases at each end". Save this in its own bed file.




# Questions 1
You now have the reproducible peaks for each protein and the different pre-mRNA regions in BED format. Report the number or fraction of reproducible peaks that are found in different pre-mRNA regions for UPF1 and PTBP1. 

Some peaks will overlap multiple pre-mRNA regions within a single gene because of several isoforms of the gene. In the Van Nostrand et al. paper, the peak annotation was chosen in the following priority order: CDS, 3'UTR, 5'UTR, and intron. For example, if a peak is found within the CDS of one transcript but the intron of another transcript (due to alternative splicing), then the annotation selected will be CDS.

To do this analysis, bedtools bedtool https://bedtools.readthedocs.io/en/latest/content/overview.html  will likely be very useful, but you can use whatever method you like. 

Please follow this template in reporting your results: Problem Set 8 template.docx  https://canvas.ucsc.edu/courses/42730/files/4010402?wrap=1. Again, you can use whatever method you like, but you need to include commands you ran to get your results. You should not have to write your own scripts as there should be available tools to do this analysis; however, if you do write your own script(s) please include a link to the source code.

Upload your commands and results in PDF format. Use this template as a guide: Problem Set 8 template.docx  https://canvas.ucsc.edu/courses/42730/files/4010402?wrap=1 

As mentioned above, UPF1 was highlighted in Figure 2a showing the fraction of peaks that overlapped with different regions. UPF1 predominantly binds to 3' UTRs. What is shown in Figure 2a is data from the HepG2 cell line. The data look similar for the K562 cell line, so you should be able to recapitulate the same results.
