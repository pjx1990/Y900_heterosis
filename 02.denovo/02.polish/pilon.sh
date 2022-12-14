#pilon --genome R900.contigs.polish.fasta --frags R900.bam --threads 20 --output pilon_2nd_polished --vcf &> pilon.log
java -Xmx400G -jar /ifs1/Software/biosoft/pilon/pilon-1.23.jar --genome R900.contigs.polish.fasta --frags R900.bam --output R900_2nd_polish --vcf &> pilon.log
