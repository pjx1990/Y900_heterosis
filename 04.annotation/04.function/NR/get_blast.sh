for i in `seq -w 00 24`;do
echo $i
diamond blastp --db /ifs1/User/pengjx/database/nr_plant/plant.dmnd  --query ../split_fa/protein.${i}.fa -e 1e-5 --outfmt 6 --more-sensitive --quiet --max-target-seqs 1 --threads 2 --out diamond.${i}.tab &
done
cat diamond*.tab >nr.tab
