#conda activate /ifs1/User/pengjx/biosoft/rmats_turbo_v4_1_1/conda_envs/rmats
rmats2sashimiplot  \
	--b1 ./2021-06-24-16:54:49_241922_bam1_1/Aligned.sortedByCoord.out.bam,./2021-06-24-16:54:49_241922_bam1_2/Aligned.sortedByCoord.out.bam,./2021-06-24-16:54:49_241922_bam1_3/Aligned.sortedByCoord.out.bam,./2021-06-24-16:54:49_241922_bam1_4/Aligned.sortedByCoord.out.bam,./2021-06-24-16:54:49_241922_bam1_5/Aligned.sortedByCoord.out.bam,./2021-06-24-16:54:49_241922_bam1_6/Aligned.sortedByCoord.out.bam \
	--b2 ./2021-06-24-16:54:49_241922_bam2_1/Aligned.sortedByCoord.out.bam,./2021-06-24-16:54:49_241922_bam2_2/Aligned.sortedByCoord.out.bam,./2021-06-24-16:54:49_241922_bam2_3/Aligned.sortedByCoord.out.bam,./2021-06-24-16:54:49_241922_bam2_4/Aligned.sortedByCoord.out.bam,./2021-06-24-16:54:49_241922_bam2_5/Aligned.sortedByCoord.out.bam,./2021-06-24-16:54:49_241922_bam2_6/Aligned.sortedByCoord.out.bam \
	-t RI \
	-e ./RI.MATS.JC.txt \
	--l1 R900 \
	--l2 Y58S \
	--exon_s 1 \
	--intron_s 5 \
	-o RI_plot_output
