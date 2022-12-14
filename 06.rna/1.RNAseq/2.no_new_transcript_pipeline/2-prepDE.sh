python2 prepDE.py -i gtflist.txt -g gene_count.csv -t transcript.csv 
python2 ./getFPKM.py -i gtflist.txt 
python2 ./getTPM.py -i gtflist.txt 
