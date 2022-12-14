##export R_LIBS=/ifs1/User/pengjx/biosoft/R_lib_tmp
#conda create -n rtracklayer install -c bioconda bioconductor-rtracklayer
#conda activate rtracklayer
#Rscript map2refGene.R gene_count_matrix.csv merged.annotated.gtf
Rscript map2refGene.R gene_fpkm_matrix.csv merged.annotated.gtf
Rscript map2refGene.R gene_tpm_matrix.csv merged.annotated.gtf
