#conda activate /ifs1/User/pengjx/biosoft/rmats_turbo_v4_1_1/conda_envs/rmats
mkdir R900-Y58S
python /ifs1/User/pengjx/biosoft/rmats_turbo_v4_1_1/rmats.py \
    --s1 R900_P.txt \
    --s2 Y58S_P.txt \
    --gtf /ifs1/User/pengjx/database/homology/MSU7/msu7.gtf \
    --bi /ifs1/User/pengjx/project/Rice/03.rna/ref-Nip/04-alternative_splicing/rMATS/index \
    -t paired \
    --readLength 150 \
    --nthread 10 \
    --od ./R900-Y58S \
    --tmp ./R900-Y58S
