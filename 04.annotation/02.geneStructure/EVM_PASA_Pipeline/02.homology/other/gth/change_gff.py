#!/lustre/home/guohan_lab/local/python-3.6/bin/python3
#liyumei
#./change-name_lym.py proteinprediction.gff proteinprediction.gff proteinprediction_r.gff

import sys
import re
fout = open(sys.argv[3],'w')

ref_dict={}
with open(sys.argv[1]) as gff:
        for line in gff:
                line_s = line.strip().split('\t')
                if 'gene' == line_s[2]:
                        ref_g = re.split('=',line_s[8])
                        ref_gene = ref_g[1]
                        ref_dict[ref_gene]=[]
                else:
                        pos = line_s[3]
                        ref_dict[ref_gene].append(pos)

with open(sys.argv[2]) as gff_r:
        for eachline in gff_r:
                i = eachline.strip().split('\t')
                info = re.split('=',i[8])
                name = info[1]
                ref_set = []
                for n in range(0,8):
                        ref_set.append(i[n])
                ref_list = '\t'.join(ref_set)
                ref_set1 = ['CDS' if x == 'exon' else x for x in ref_set]
                ref_list1 = '\t'.join(ref_set1)
                if 'gene' == i[2]:
                        fout.write(eachline)
                elif 'exon' == i[2]:
                        if name in ref_dict:
                                vs = ref_dict[name]
                                len_vs = len(vs)
                                for a in range(0,len_vs):
                                        if vs[a] == i[3]:
                                                b = vs.index(vs[a])
                                                fout.write('%s\tID=%s.t%d;Parent=%s\n'%(ref_list,name,b+1,name))
                                                fout.write('%s\tID=%s.c%d;Parent=%s\n'%(ref_list1,name,b+1,name))
fout.close()

