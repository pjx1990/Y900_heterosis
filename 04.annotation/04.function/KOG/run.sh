#diamond makedb --in kyva -d kog
diamond blastp --db kog.dmnd --query ../protein.fa -e 1e-5 --outfmt 6 --more-sensitive --quiet --max-target-seqs 1 --threads 10 --out R900.kog.tab
