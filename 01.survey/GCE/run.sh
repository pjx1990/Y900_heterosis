#~/biosoft/gce-1.0.0/kmerfreq/kmer_freq_hash/kmer_freq_hash \
#        -k 17 -l reads.list -a 10 -d 10 -t 24 -i 5000000 -o 0 -p species &> kmer_freq.log
#~/biosoft/gce-1.0.0/gce \
#    -f species.freq.stat -c 85 -g 4112118028 -m 1 -D 8 -b 1 > species.table 2> species.log        

/ifs1/User/pengjx/biosoft/gce-1.0.0/kmerfreq/kmer_freq_hash/kmer_freq_hash -k 17 -L 150 -i 450000000 -t 20 -l read.list -p R900 2>kmerfreq.log
