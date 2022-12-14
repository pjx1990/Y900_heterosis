# conda activate /ifs1/User/pengjx/biosoft/rmats_turbo_v4_1_1/conda_envs/rmats
# mkdir index
STAR  \
	--runMode genomeGenerate \
	--genomeDir index \
	--runThreadN 20 \
	--genomeFastaFiles /ifs1/User/pengjx/database/homology/MSU7/msu7.fa \
	--sjdbGTFfile /ifs1/User/pengjx/database/homology/MSU7/msu7.gtf \
	--sjdbOverhang 149
