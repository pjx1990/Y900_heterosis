##conda activate predict
##uniprot plant拆分100份
#ls /ifs1/User/pengjx/database/uniprot_plant/split/pro_rmdup.0*.fa |while read i;do
#sample=`echo $i |sed 's#.*/##g'`
#echo $sample
#echo "exonerate --model protein2genome --ryo '#PIS\t%pi\t%ps\t%qal\t%ql\n' --score 800 --saturatethreshold 100 --dnahspthreshold 60 --dnawordlen 14 --forwardcoordinates FALSE --softmasktarget TRUE --showtargetgff TRUE --showquerygff FALSE --showalignment FALSE --showvulgar FALSE --showcigar FALSE $i  ../58S.genome.fa >${sample}.out"
for i in `seq -w 0 99`;do
#nohup exonerate --model protein2genome --ryo '#PIS\t%pi\t%ps\t%qal\t%ql\n' --score 800 --saturatethreshold 100 --dnahspthreshold 60 --dnawordlen 14 --forwardcoordinates FALSE --softmasktarget TRUE --showtargetgff TRUE --showquerygff FALSE --showalignment FALSE --showvulgar FALSE --showcigar FALSE /ifs1/User/pengjx/database/uniprot_plant/split/pro_rmdup.0${i}.fa  ../58S.genome.fa >pro_rmdup.0${i}.out &
echo pro_rmdup.0${i}.out
perl /ifs1/User/pengjx/biosoft/EVidenceModeler-master/EvmUtils/misc/Exonerate_to_evm_gff3.pl pro_rmdup.0${i}.out >out.0${i}.gff 
done

cat out*.gff >merge.gff
