# hardmasker（重复序列NN）
~/biosoft/RepeatMasker/RepeatMasker -nolow -no_is -norna -e ncbi -parallel 30 -lib 58S_custom_repeat.lib 58S.genome.fa

# softmasker（重复序列小写）
~/biosoft/RepeatMasker/RepeatMasker -nolow -no_is -norna -xsmall -e ncbi -parallel 30 -lib 58S_custom_repeat.lib -gff 58S.genome.fa
