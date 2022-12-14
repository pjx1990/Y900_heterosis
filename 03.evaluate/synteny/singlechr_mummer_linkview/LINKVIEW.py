#!/usr/bin/env python
## _*_coding:utf-8_*_
from __future__ import division
import argparse
import re
from fractions import Fraction
import sys
import os
import interval

style_css = {
    'classic': '''
        <defs><style>
            .chro{
                fill: #838B83;            
            }
            .align {
                fill: #607B8B;
                opacity: 0.5;
            }
            .line {
                stroke: #000000;
                stroke-width: 3.5px;
            }
            .exon {
                fill: #36648B;
            }
            .UTR3 {
                fill: #2F4F4F;
            }
            .UTR5 {
                fill: #2F4F4F;
            }
            .intron {
                stroke: #36648B;
                stroke-width: 1.5px;
            }        
        </style></defs>
            ''',
    'simple': '''
        <defs><style>
            .chro{
                stroke: #000000;
                fill: none;
            }
            .align {
                fill: #B7B7B7;
                opacity: 0.5;
            }
            .line {
                stroke: #000000;
                stroke-width: 3.5px;
            }
            .exon {
                fill: 	#515151;
            }
            .UTR3 {
                fill: #2F4F4F;
            }
            .UTR5 {
                fill: #2F4F4F;
            }
            .intron {
                stroke: #515151;
                stroke-width: 1.5px;
            }        
        </style></defs>
    ''',
}
class ArgumentError(Exception):
    def __init__(self,ErrorType,ErrorValue):
        self.ErrorType = ErrorType
        self.ErrorValue = ErrorValue
    def __str__(self):
        if (self.ErrorType == "type"):
            return("[Error] Unkonwn input type '{}', only be 0, 1 or 2 !".format(self.ErrorValue))
        if (self.ErrorType == "chro_len"):
            return("[Error] chro_len file '{}' not exists !".format(self.ErrorValue))
        if (self.ErrorType == "karyotype"):
            return("[Error] karyotype file '{}' not exists !".format(self.ErrorValue))
        if (self.ErrorType == "parameter"):
            return("[Error] parameter file '{}' not exists !".format(self.ErrorValue))
        if (self.ErrorType == "highlight"):
            return("Error] highlight file '{}' not exists !".format(self.ErrorValue))
        if (self.ErrorType == "style"):
            return("Error] style can only be specified as classic or simple.")
        
class FormatError(Exception):
    def __init__(self,ErrorType,FileName,Line):
        self.ErrorType = ErrorType
        self.FileName = FileName
        self.Line = Line
    def __str__(self):
        if (self.ErrorType == "input"):
            return("\n\t[Error] Wrong format in karyotype file '{}':\n\t{}\n\tType parameter error or format error, please check carefully !".format(self.FileName,self.Line))
        if (self.ErrorType == "karyotype"):
            return("\n\t[Error] Wrong format in karyotype file '{}':\n\t{}\n\tThe correct format should be chro1:[start1:end1]...".format(self.FileName,self.Line))
        if (self.ErrorType == "karyotype_start_end"):
            return("\n\t[Error] Wrong format in karyotype file '{}':\n\t{}\n\tEnd must be larger than start".format(self.FileName,self.Line))
        if (self.ErrorType == "gff"):
            return("\n\t[Error] Wrong format in gff file '{}':\n\t{}\n\tplease check!".format(self.FileName,self.Line))
        if (self.ErrorType == "gff_no_parent"):
            return("\n\t[Error] Wrong format in gff file '{}':\n\t{}\n\tcan not find Parent ID!".format(self.FileName,self.Line))
class FatalError(Exception):
    def __init__(self,ErrorType,chro_name):
        self.ErrorType = ErrorType
        self.chro_name = chro_name
    def __str__(self):
        if(self.ErrorType == 1):
            return('\n\t[Error] {} has no alignment in the corresponding area!\n\tPlease relax the filter or change the KARYOTYPE\n'.format(self.chro_name))
        if(self.ErrorType == 2):
            return('\n\t[Error] Did not find any alignment!\n\tPlease relax the filter or modify the KARYOTYPE\n')

#??????????????? Chro ?????????????????????????????????????????????????????????
class Chro():
    def __init__(self,name,start,end,is_full):
        self.name = name
        self.start = start
        self.end = end
        self.length = end-start+1
        self.is_full = is_full
        self.left = None
        self.right = None
        self.top = None
        self.level = None

    def coordinate(self,pos,is_up,is_start=False):
        if self.left and self.right and self.top:
            if is_up: y = self.top
            else: y = self.top+args.chro_thickness
            if is_start: x = self.left + (pos-self.start)*scale
            else: x = self.left+(pos-self.start+1)*scale
            return (x, y)
        else: return None

def parse_gff(gffs):
    #???????????????gene_info??????
    #mRNA_info ???????????????
    global mRNA_info
    mRNA_info = {}

    def parse_attributes(attributes_str):
        attributes = attributes_str.split(';')
        attributes_info = {}
        for attribute in attributes:
            key,value = attribute.split('=')
            attributes_info[key] = value
        return attributes_info
    def parse_single_gff(gff):
        GFF = open(gff,'r')
        for line in GFF:
            line=line.strip()
            if line=='': continue
            items = line.split('\t')
            if len(items) != 9: raise FormatError('gff',gff,line)
            seqid,source,gene_type,start,end,score,strand,phase,attributes = items
            start = int(start)
            end = int(end)
            attributes_info = parse_attributes(attributes)
            if gene_type == 'gene':
                gene_id = attributes_info['ID']
                gene_info.setdefault(gene_id,{})
                gene_info[gene_id]['chro'] = seqid
                gene_info[gene_id]['strand'] = strand
                gene_info[gene_id]['gene'] = (start,end)
            elif gene_type == 'mRNA':
                if not 'Parent' in attributes_info: raise FormatError('gff_no_parent',gff,line)
                gene_id = attributes_info['Parent']
                mRNA_id = attributes_info['ID']
                gene_info.setdefault(gene_id,{})
                gene_info[gene_id].setdefault('mRNA',{})
                gene_info[gene_id]['mRNA'][mRNA_id] = {}
            else:
                # pass
                if not 'Parent' in attributes_info: raise FormatError('gff_no_parent',gff,line)
                mRNA_id = attributes_info['Parent']
                mRNA_info.setdefault(mRNA_id,{})
                mRNA_info[mRNA_id].setdefault(gene_type,[])
                mRNA_info[mRNA_id][gene_type].append((start,end))           
        GFF.close()
    for gff in gffs:
        parse_single_gff(gff)
    for gene_id in gene_info:
        for mRNA_id in gene_info[gene_id]['mRNA']: 
            gene_info[gene_id]['mRNA'][mRNA_id] = mRNA_info[mRNA_id]

def main(args):

    global scale
    global gene_info
    gene_info = {}
    #gene_info???key???gene_id, ??????????????????, ?????????????????????
    #{  'chro': 'xxx', 
    #   'strand': '-', 'gene': (123, 456),
    #   'mRNA':{
    #       mRNA1:  #??????mRNA_info[mRNA1]
    #       {
    #       'exon': [(123, 456), (123, 456), (123, 456)], 
    #       'CDS': [(123, 456), (123, 456), (123, 456)]
    #       },
    #       ...    
    #   }
    #}

    if args.style:
        if not args.style in ['classic','simple']: raise ArgumentError('style',args.type)
        # svg_content_style = style_css[args.style]
        svg_content_style = re.sub(r'\s+','',style_css[args.style])
    if args.gff:
        gffs = args.gff.split(',')
        parse_gff(gffs)
        # print(gene_info['BnaA10G0244800ZS']['chro'])

    relations = [] #????????????????????????????????????alignment????????????{"chro1": chr, "start1": int, "end1": int, "chro2":...}
    coors_in_chro = {} #??????????????????????????????????????????????????????????????????alignment?????????????????????
    chro_len = {} #?????????????????????????????????????????????
    chro_lst = {} #?????????????????????Chro???????????????
    order = [] #?????????????????????????????????????????????????????????
    auto_start_end = [] #????????????????????????????????????????????????????????????
    
    
        
    #parse the main input file(alignment file generated by blastn|nucmer or customized)
    #????????????????????????????????????blastn???nuncmer ?????????????????????????????????
    f=open(args.input,'r')
    for line in f:
        if line.startswith('#'):continue
        line = line.strip()
        opacity = ''
        color = ''
        if args.type == 0:
            # for default input format
            chro1,start1,end1,chro2,start2,end2,color = re.match(r'(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s*(\S+)?',line).group(1,2,3,4,5,6,7)
            if color and ':' in color: color,opacity = color.split(':')
        elif args.type == 1:
            # for blastn (-outfmt 7) output
            items = line.split('\t')
            chro1,chro2,identity,alignment_length,mismatches,gap_opens,start1,end1,start2,end2,evalue,bit_score = items
            identity,alignment_length,evalue,bit_score = float(identity),int(alignment_length),float(evalue),float(bit_score)
            if(not (identity>args.min_identity and alignment_length>args.min_alignment_length and evalue<args.max_evalue and bit_score>args.min_bit_score ) ):continue            
        elif args.type == 2:
            # for nucmer output (coords format)
            items = re.split(r'\s+\|\s+|\s+',line)
            if len(items) != 13: continue
            start1,end1,start2,end2,len1,len2,identity,len_chro1,len_chro2,cov_chro1,cov_chro2,chro1,chro2 = items
            identity,len1,len2 = float(identity),int(len1),int(len2)
            alignment_length = int((len1+len2)/2)
            if(not (identity>args.min_identity and alignment_length>args.min_alignment_length) ): continue
            chro_len[chro1] = int(len_chro1)
            chro_len[chro2] = int(len_chro2)
                        
        else: raise ArgumentError('type',args.type)
        if not opacity: opacity = None
        if not color: color = None
        try:
            start1,end1,start2,end2 = int(start1),int(end1),int(start2),int(end2)
        except: raise FormatError('input',args.input,line)

        coors_in_chro.setdefault(chro1,[]);coors_in_chro.setdefault(chro2,[])
        coors_in_chro[chro1].extend([start1,end1])
        coors_in_chro[chro2].extend([start2,end2])
        relations.append({'chro1':chro1,'start1':start1,'end1':end1,'chro2':chro2,'start2':start2,'end2':end2,'color':color,'opacity':opacity,'display':True})
    
    # parse chro_len file which stores the length of each sequence
    # ?????? chro_len ??????
    if args.chro_len:
        if not os.path.exists(args.chro_len): raise ArgumentError('chro_len',args.chro_len)
        CHRO_LEN = open(args.chro_len,'r')
        for line in CHRO_LEN:
            line = line.strip()
            chr_name,length = re.match(r'^(\S+)\s+(\S+)\s*$',line).group(1,2)
            chro_len[chr_name] = int(length)
        CHRO_LEN.close()
    
    # ?????????Chro????????????????????????????????????chro_lst?????????
    # ??????Chro???????????????start???end???????????????????????????????????????????????????is_full?????????[true, true]?????????????????????????????????
    for chro in coors_in_chro:
        chro_lst[chro]=Chro(chro,min(coors_in_chro[chro]),max(coors_in_chro[chro]),[True,True])
    
    #?????????????????????K.TXT??????????????????K.TXT????????????????????????????????????????????????????????????????????????
    if(args.karyotype):
        if not os.path.exists(args.karyotype): raise ArgumentError('karyotype',args.karyotype)
        level = 0
        K = open(args.karyotype,'r')
        for line in K:
            if line.startswith('#'): continue
            # order.setdefault(level,[])
            order.append([])
            line = line.strip()
            chros = re.split(r'\s+',line)
            for chro in chros:
                items=chro.split(':')
                name=items[0]
                if not name in chro_lst: sys.stderr.write('[Warning] {} has no alignment relationship with other chromosomes !\n'.format(name))
                if not len(items) in (1,3): raise FormatError('karyotype',args.karyotype,line)
                if len(items)==1:auto_start_end.append(name)
                if len(items)==3:
                    if not (re.match(r'^\d+$',items[1]) and re.match(r'^\d+$',items[2])):
                        raise FormatError('karyotype',args.karyotype,line)
                    if not int(items[1])<int(items[2]):
                        raise FormatError('karyotype_start_end',args.karyotype,line)
                    chro_lst[name]=Chro(name,int(items[1]),int(items[2]),[True,True])
                order[level].append(name)
            level+=1
        K.close()

        #?????????????????????K.TXT????????????????????????????????????alignment???????????????
        #?????????????????????alignment
        for i in range(len(relations)):
            relation=relations[i]
            chro1 = relation['chro1']
            chro2 = relation['chro2']
            # chro1???chro2 ???order???????????? ????????????
            if not any([chro1 in x for x in order]):relations[i]['display'] = False;continue
            if not any([chro2 in x for x in order]):relations[i]['display'] = False;continue
            #???alignment????????????????????????????????????????????????????????????????????????????????????????????????????????????
            #???????????????????????????????????????????????????????????????????????????

            #??????????????????????????????
            reverse = False
            if(relation['start1']-relation['end1'])*(relation['start2']-relation['end2'])<0: reverse=True
            
            #tmp_its1???alignment????????????????????????????????????????????????????????????????????????alignment
            tmp_its1 = interval.intersection([relation['start1'],relation['end1']] , [chro_lst[relation['chro1']].start,chro_lst[relation['chro1']].end])
            if not tmp_its1: relations[i]['display'] = False;continue
            #?????????????????????len1
            tmp_start1,tmp_end1 = sorted([relation['end1'],relation['start1']])
            len1 = tmp_end1-tmp_start1+1
            #tmp_its1 ???alignment???????????????????????????????????????
            tmp_its1=[Fraction((tmp_its1[0]-tmp_start1),len1),Fraction((tmp_its1[1]-tmp_start1+1),len1)]

            #????????????????????????????????????
            tmp_its2=interval.intersection([relation['start2'],relation['end2']] , [chro_lst[relation['chro2']].start,chro_lst[relation['chro2']].end])
            if not tmp_its2: relations[i]['display']=False;continue
            tmp_start2,tmp_end2 = sorted([relation['end2'],relation['start2']])
            len2 = tmp_end2-tmp_start2+1
            tmp_its2=[Fraction((tmp_its2[0]-tmp_start2),len2),Fraction((tmp_its2[1]-tmp_start2+1),len2)]

                
            
            if(reverse == False):
                #??????????????????????????????tmp?????????????????????????????????
                tmp_its1=tmp_its2=interval.intersection(tmp_its1,tmp_its2)
                if not tmp_its1: relations[i]['display'] = False;continue
            else:
               
                tmp_its1=[1-tmp_its1[1],1-tmp_its1[0]]
                tmp_its2=interval.intersection(tmp_its1,tmp_its2)               
                if not tmp_its2: relations[i]['display'] = False;continue
                tmp_its1=[1-tmp_its2[1],1-tmp_its2[0]]
                tmp_start1=min(tmp_start1,tmp_end1)
                tmp_start2=min(tmp_start2,tmp_end2)
                tmp_its1.reverse()
            relations[i]['start1'] = int(tmp_start1 + tmp_its1[0]*len1)
            if reverse: relations[i]['start1'] -= 1
            relations[i]['start2'] = int(tmp_start2 + tmp_its2[0]*len2)
            relations[i]['end1'] = int(tmp_start1 + tmp_its1[1]*len1 -1)
            if reverse: relations[i]['end1'] += 1         
            relations[i]['end2'] = int(tmp_start2 + tmp_its2[1]*len2 -1)

        relations=[x for x in relations if x['display']==True]

        #???K.TXT?????????????????????????????????????????????????????????????????????????????????

        #????????????????????????coors_in_chro[chro]????????????alignment????????????
        for chro in auto_start_end:
            coors_in_chro[chro]=[]
        #???????????????????????????????????????alignment???????????????relation?????????
        for relation in relations:
            if relation['chro1'] in auto_start_end:
                coors_in_chro[relation['chro1']].append(relation['start1'])
                coors_in_chro[relation['chro1']].append(relation['end1'])
            if relation['chro2'] in auto_start_end:
                coors_in_chro[relation['chro2']].append(relation['start2'])
                coors_in_chro[relation['chro2']].append(relation['end2'])
        for chro in auto_start_end:
            if not coors_in_chro[chro]: raise FatalError(1,chro)
            chro_lst[chro].start=min(coors_in_chro[chro])
            chro_lst[chro]=Chro(chro,min(coors_in_chro[chro]),max(coors_in_chro[chro]),[True,True])
            print("[Info]\t{}\t{}\t{}".format(chro,min(coors_in_chro[chro]),max(coors_in_chro[chro])))

    # ????????????????????????K.TXT??????????????????????????????????????????????????????
    else:
    #====Arrange the order of chro_lst on the image. If you specify a Karyotype file, this step is omitted.===
        link = {}
        if not relations: raise FatalError(2,'')
        for relation in relations:
            chro1 = relation['chro1']
            chro2 = relation['chro2']
            link.setdefault(chro1, [])
            link.setdefault(chro2, [])
            if not chro2 in link[chro1]: link[chro1].append(chro2)
            if not chro1 in link[chro2]: link[chro2].append(chro1)

        global chro_ordered
        chro_ordered = []
        first = min(link.keys(),key=lambda x:len(link[x]))
        chro_ordered.append(first)
        order.append([first])

        def find_next_chro(*chros):
            global  chro_ordered
            next_chros = []
            for chro in chros:
                for next_chro in link[chro]:
                    if not next_chro in chro_ordered:
                        next_chros.append(next_chro)
                chro_ordered.extend(next_chros)
                if next_chros: order.append(next_chros)
                find_next_chro(*next_chros)

        find_next_chro(first)

    #????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????level????????????????????????
    
    #????????????????????????
    label_font_size={}
    show_pos_with_label={}
    no_label={}
    label_angle={}
    chro_axis={}
    gap_length={}

    max_len=0
    lens={}
    middle_spaces={}
    #?????????level??????????????????????????????????????????????????????????????????
    for level,chrs in enumerate(order):
        num = len(chrs)
        length = 0
        for chro in chrs: length += chro_lst[chro].length
        label_font_size[level] = args.label_font_size
        show_pos_with_label[level] = args.show_pos_with_label
        no_label[level] = args.no_label
        label_angle[level] = args.label_angle
        chro_axis[level] = args.chro_axis
        gap_length[level] = args.gap_length
        #lens ????????????level?????????????????????????????????????????????????????????????????????????????????
        lens[level] = length
    #????????????????????? ????????????P.TXT ???????????????P.TXT????????????level???????????????????????????????????????
    if(args.parameter):
        if not os.path.exists(args.parameter): raise ArgumentError('parameter',args.parameter)
        P = open(args.parameter,'r')
        level = 0
        for line in P:
            m1 = re.search(r'label_font_size=(\d+(\.\d+)?)',line)
            if m1:label_font_size[level] = m1.group(1)
            m2 = re.search(r'show_pos_with_label=(\d+(\.\d+)?)',line)
            if m2:show_pos_with_label[level] = m2.group(1)
            m3 = re.search(r'no_label=(\d+(\.\d+)?)',line)
            if m3:no_label[level] = m3.group(1)
            m4 = re.search(r'gap_length=(\d+(\.\d+)?)',line)
            if m4:gap_length[level] = float(m4.group(1))
            m5 = re.search(r'label_angle=(\d+(\.\d+)?)',line)
            if m5:label_angle[level] = 360-float(m5.group(1))
            m6 = re.match(r'chro_axis=(\d+(\.\d+)?)',line)
            if m6:chro_axis[level] = m6.group(1)
            level += 1
        P.close()
    for level,chrs in enumerate(order): #???middle_spaces[level]????????????
        if(gap_length[level] > 1): gap_len = int(gap_length[level])
        else:gap_len = lens[level] * float(gap_length[level])
        middle_spaces[level] = gap_len
        lens[level] = lens[level] + gap_len * (len(order[level])-1)

    max_len = max(lens.values())
    if args.label_angle and len(label_angle)>1:
        label_angle[max(label_angle.keys())] = 360 - label_angle[max(label_angle.keys())]

    # space_single=(args.svg_width)*args.svg_space/2
    # ?????????????????????????????????
    scale = args.svg_width*(1-args.svg_space)/max_len
    # ????????????????????????????????????L?????????????????????level???1/5??????????????????
    L = max_len/5
    # ????????????????????????????????????L?????????????????????
    if(args.scale):
        L,suf=re.match(r'(\d+)([km]?)',args.scale).group(1,2)
        L=int(L)
        if suf=='k':L=L*1000
        elif suf=='m':L=L*1000000

    def get_L_str(L):
        i = 10
        n = 10
        unit = 1
        while 1:
            result=int(L/i)
            if not result: break
            n,unit=result,i
            i*=10
        L1=n*unit
        if(unit>=10000000):suffix='0 Mb'
        elif(unit>=1000000):suffix=' Mb'
        elif(unit>=100000):suffix='00 Kb'
        elif(unit>=10000):suffix='0 Kb'
        elif(unit>=1000):suffix=' Kb'
        elif(unit>=100):suffix='00 bp'
        elif(unit>=10):suffix='0 bp'
        else:suffix=' bp'
        s=str(n)+suffix
        return(L1,s)
    L,S = get_L_str(L) #L,S ????????????????????????????????????????????????????????????????????????????????????

    #????????????Chro?????????????????????????????????????????????????????????svg??????????????????????????????
    space_vertical = args.svg_height/(len(order)+1) #???????????????????????????
    top=0 
    line_length=args.svg_width*(1-args.svg_space)/40 #?????????????????????????????????????????????
    for level,chros in enumerate(order):
        left = (args.svg_width-lens[level]*scale)/2 #???????????????????????????
        top += space_vertical #???????????????????????????
        for chro in chros:
            # ????????????????????????????????????????????????????????????????????????????????????????????????????????????
            if(chro_lst[chro].name in chro_len):
                chro_lst[chro].is_full = [chro_lst[chro].start==1, chro_lst[chro].end==chro_len[chro_lst[chro].name]]
            chro_lst[chro].level = level
            chro_lst[chro].top = top
            chro_lst[chro].left = left
            chro_lst[chro].right = left + chro_lst[chro].length*scale
            if not chro_lst[chro].is_full[0]:
                chro_lst[chro].left += line_length
                chro_lst[chro].right += line_length
            left = chro_lst[chro].right + middle_spaces[level]*scale
            if not chro_lst[chro].is_full[1]: left += line_length

#==================creat svg=================
    #?????????????????????????????????????????????chro?????????????????????????????????'top'???'bottom'?????????????????????????????????????????????????????????
    def get_svg_content_Axis(chro,position):
        axis_left = chro_lst[chro].left
        axis_right = chro_lst[chro].right
        axis_top = chro_lst[chro].top
        axis_start = chro_lst[chro].start
        axis_end = chro_lst[chro].end
        
        for unit in [5,50,500,5000,50000,500000,5000000]:
            if args.chro_axis_density <= L/unit < 10*args.chro_axis_density:
                break
        unit2 = unit
        unit1 = int(unit2/5)
        unit3 = unit2*2

        def get_unit_start(unit,start):
            i = start
            while(1):
                if i%unit == 0: break
                i+=1
            unit_start=i
            return unit_start

        unit1_start = get_unit_start(unit1,axis_start)
        unit2_start = get_unit_start(unit2,axis_start)
        unit3_start = get_unit_start(unit3,axis_start)

        unit1_point = []
        i = unit1_start
        while(i <= axis_end):
            unit1_point.append(i)
            i += unit1

        unit2_point = []
        i = unit2_start
        while(i <= axis_end):
            unit2_point.append(i)
            i += unit2

        unit3_point = []
        labels = []
        i = unit3_start
        while(i <= axis_end):
            unit3_point.append(i)
            if axis_end > 10000:
                labels.append('{:,.3f}'.format(i/1000000)+' Mb')
            elif unit3 <= 10000:
                labels.append('{:,.2f}'.format(i/1000)+' Kb')
            elif unit3 > 10000:
                labels.append('{:,.2f}'.format(i/1000000)+' Mb')
            i += unit3

        unit1_point = [x for x in unit1_point if not x in unit2_point]
        unit2_point = [x for x in unit2_point if not x in unit3_point]

        unit1_point = [(x-axis_start)*scale for x in unit1_point]
        unit2_point = [(x-axis_start)*scale for x in unit2_point]
        unit3_point = [(x-axis_start)*scale for x in unit3_point]

        axis_angle=25
        if position == 'top':
            sign = -1
            axis_angle=360-axis_angle
        elif position == 'bottom':
            sign = 1
            axis_top+=args.chro_thickness
        chro_axis = ''
        chro_axis += '<path d="M {} {} L {} {} " stroke="black" fill="none"/>\n'.format(axis_left,axis_top,axis_right,axis_top)
        for point in unit1_point:
            chro_axis += '<path d="M {} {} L {} {} " stroke="black" fill="none"/>\n'.format(axis_left+point,axis_top,axis_left+point,axis_top+2*sign)
        for point in unit2_point:
            chro_axis += '<path d="M {} {} L {} {} " stroke="black" fill="none"/>\n'.format(axis_left+point,axis_top,axis_left+point,axis_top+5*sign)
        for i in range(len(unit3_point)):
            point = unit3_point[i]
            label = labels[i]
            chro_axis += '<path d="M {} {} L {} {} " stroke="black" fill="none"/>\n'.format(axis_left+point,axis_top,axis_left+point,axis_top+8*sign)
            chro_axis += '<text x="{}" y="{}" fill="black" transform="rotate({},{} {})" font-size="9">{}</text>\n'.format(axis_left+point,axis_top+12*sign,axis_angle,axis_left+point,axis_top+12*sign,label)
        return chro_axis
    #???????????????????????????
    def get_gene_structure(chro):
        gene_structure_svg = ''
        chro_start = chro_lst[chro].start
        chro_end = chro_lst[chro].end
        gene_id_display = [gene_id for gene_id in gene_info.keys() 
                        if gene_info[gene_id]['chro'] == chro
                        and interval.relation(gene_info[gene_id]['gene'], (chro_start,chro_end)) != 1
                        ]
        print("[Info]\tThese genes will be displayed\t{}".format(', '.join(gene_id_display)))
        for gene_id in gene_id_display:
            strand = gene_info[gene_id]['strand']
            mRNA_id = sorted(gene_info[gene_id]['mRNA'].keys())[0]
            gene_itv = gene_info[gene_id]['gene']
            exons = gene_info[gene_id]['mRNA'][mRNA_id]['exon']
            UTR3s=[]
            UTR5s=[]
            if 'three_prime_UTR' in gene_info[gene_id]['mRNA'][mRNA_id]: 
                UTR3s = gene_info[gene_id]['mRNA'][mRNA_id]['three_prime_UTR']
            if 'five_prime_UTR' in gene_info[gene_id]['mRNA'][mRNA_id]: 
                UTR5s = gene_info[gene_id]['mRNA'][mRNA_id]['five_prime_UTR']
            introns = interval.complement(gene_itv, exons+UTR3s+UTR5s)
            
            exons_tmp = []
            for exon in exons:
                exons_tmp.extend(interval.complement(exon,UTR3s+UTR5s))
            exons = exons_tmp

            for exon in exons:                
                x1,y = chro_lst[chro].coordinate(exon[0],is_up=True,is_start=True)
                x2,y = chro_lst[chro].coordinate(exon[1],is_up=True,is_start=False)
                y1 = y + args.chro_thickness*0.2
                y2 = y + args.chro_thickness*0.8
                y3 = y + args.chro_thickness*0.5
                length = x2-x1
                x3 = x1+length*0.2
                x4 = x2-length*0.2
                if strand=='+':
                    gene_structure_svg += '<path d="M{},{} L{},{} L{},{} L{},{} L{},{} Z" clip-path="url(#clipPath1)" class="exon"/>\n'.format(x1,y1, x4,y1, x2,y3, x4,y2, x1,y2)
                else:
                    gene_structure_svg += '<path d="M{},{} L{},{} L{},{} L{},{} L{},{} Z" clip-path="url(#clipPath1)" class="exon"/>\n'.format(x2,y1, x2,y2, x3,y2, x1,y3, x3,y1)
            for intron in introns:
                x1,y = chro_lst[chro].coordinate(intron[0],is_up=True,is_start=True)
                x2,y = chro_lst[chro].coordinate(intron[1],is_up=True,is_start=False)
                y += args.chro_thickness*0.5
                gene_structure_svg += '<line x1="{}" y1="{}" x2="{}" y2="{}" clip-path="url(#clipPath1)" class="intron"/>\n'.format(x1, y, x2, y)
            # print(mRNA_id,introns)
            for UTR3 in UTR3s:
                x1,y = chro_lst[chro].coordinate(UTR3[0],is_up=True,is_start=True)
                x2,y = chro_lst[chro].coordinate(UTR3[1],is_up=True,is_start=False)
                y1 = y + args.chro_thickness*0.2
                y2 = y + args.chro_thickness*0.8
                y3 = y + args.chro_thickness*0.5
                length = x2-x1
                x3 = x1+length*0.2
                x4 = x2-length*0.2
                if strand=='+':
                    gene_structure_svg += '<path d="M{},{} L{},{} L{},{} L{},{} L{},{} Z" clip-path="url(#clipPath1)" class="UTR3"/>\n'.format(x1,y1, x4,y1, x2,y3, x4,y2, x1,y2, "purple",1)
                else:
                    gene_structure_svg += '<path d="M{},{} L{},{} L{},{} L{},{} L{},{} Z" clip-path="url(#clipPath1)" class="UTR3"/>\n'.format(x2,y1, x2,y2, x3,y2, x1,y3, x3,y1, "purple",1)
                
            for UTR5 in UTR5s:
                x1,y = chro_lst[chro].coordinate(UTR5[0],is_up=True,is_start=True)
                x2,y = chro_lst[chro].coordinate(UTR5[1],is_up=True,is_start=False)
                y1 = y + args.chro_thickness*0.2
                y2 = y + args.chro_thickness*0.8
                y3 = y + args.chro_thickness*0.5
                length = x2-x1
                x3 = x1+length*0.2
                x4 = x2-length*0.2
                if strand=='+':
                    gene_structure_svg += '<path d="M{},{} L{},{} L{},{} L{},{} L{},{} Z" fill="{}" opacity="{}" clip-path="url(#clipPath1)" class="UTR5"/>\n'.format(x1,y1, x4,y1, x2,y3, x4,y2, x1,y2, "purple",1)
                else:
                    gene_structure_svg += '<path d="M{},{} L{},{} L{},{} L{},{} L{},{} Z" fill="{}" opacity="{}" clip-path="url(#clipPath1)" class="UTR5"/>\n'.format(x2,y1, x2,y2, x3,y2, x1,y3, x3,y1, "purple",1)
                
        return gene_structure_svg

        pass
    
    bottom_level=len(order)-1

    svg_content_line = ''
    svg_content_chro = ''
    svg_content_clipPath = '<defs><clipPath id="clipPath1">\n'
    svg_content_label = ''
    svg_content_align = ''
    svg_content_scale = ''
    svg_content_highlight = ''
    svg_content_axis = ''
    svg_content_gene = ''



    for chro in chro_lst:
        if not any([chro in x for x in order]): continue
        angle_text = ''
        if not chro_lst[chro].is_full[0]:
            svg_content_line += '''<line x1="{}" y1="{}" x2="{}" y2="{}" class="line"/>\n'''.format(chro_lst[chro].left-line_length,chro_lst[chro].top+args.chro_thickness/2,chro_lst[chro].left,chro_lst[chro].top+args.chro_thickness/2)
        svg_content_chro += '''<rect x="{}" y="{}" width="{}" height="{}" fill="grey" class="chro"/>\n'''.format(chro_lst[chro].left, chro_lst[chro].top, chro_lst[chro].right-chro_lst[chro].left, args.chro_thickness)
        #???????????????gff????????????????????????????????????????????????
        if(args.gff):
            svg_content_clipPath += '''<rect x="{}" y="{}" width="{}" height="{}" fill="grey" class="chro"/>\n'''.format(chro_lst[chro].left, chro_lst[chro].top, chro_lst[chro].right-chro_lst[chro].left, args.chro_thickness)
            svg_content_gene += get_gene_structure(chro)
        if not chro_lst[chro].is_full[1]:
            svg_content_line += '''<line x1="{}" y1="{}" x2="{}" y2="{}" class="line"/>\n'''.format(chro_lst[chro].right,chro_lst[chro].top+args.chro_thickness/2,chro_lst[chro].right+line_length,chro_lst[chro].top+args.chro_thickness/2)

        if(chro_lst[chro].level == 0):
            label_x = chro_lst[chro].left
            label_y = chro_lst[chro].top-args.chro_thickness/2 - 5
            if chro_axis[chro_lst[chro].level]:
                svg_content_axis += get_svg_content_Axis(chro,'top')
                label_y -= 25
        elif(chro_lst[chro].level==bottom_level):
            label_x = chro_lst[chro].left
            label_y = chro_lst[chro].top+args.chro_thickness*2 + 5
            label_y += args.chro_thickness - 1
            if chro_axis[chro_lst[chro].level]:
                svg_content_axis += get_svg_content_Axis(chro,'bottom')
                label_y += 25
        else:
            label_x = chro_lst[chro].right+label_font_size[chro_lst[chro].level]/5
            label_y = chro_lst[chro].top+args.chro_thickness
            if not chro_lst[chro].is_full[1]: label_x += line_length
        if not int(no_label[chro_lst[chro].level]):
            label = chro_lst[chro].name
            if int(show_pos_with_label[chro_lst[chro].level]):label="{} {:,} ~ {:,} bp".format(label,chro_lst[chro].start,chro_lst[chro].end);
            angle_text = 'transform="rotate({},{} {})"'.format(label_angle[chro_lst[chro].level],label_x,label_y)
            svg_content_label += '''<text x="{}" y="{}" fill="black" font-size="{}" {} class="label">{}</text>\n'''.format(label_x,label_y,label_font_size[chro_lst[chro].level],angle_text,label)
    svg_content_clipPath += '</clipPath></defs>\n'
    for relation in relations:
        chro1 = relation['chro1']
        chro2 = relation['chro2']
        is_up = chro_lst[chro1].level>chro_lst[chro2].level
        vertex1 = chro_lst[chro1].coordinate(relation['start1'],is_up,is_start = relation['start1']<relation['end1'])
        vertex2 = chro_lst[chro2].coordinate(relation['start2'],not is_up,is_start = relation['start2']<relation['end2'])
        vertex3 = chro_lst[chro2].coordinate(relation['end2'],not is_up,is_start = relation['end2']<relation['start2'])
        vertex4 = chro_lst[chro1].coordinate(relation['end1'],is_up,is_start = relation['end1']<relation['start1'])
        #?????????????????????
        particular_style = ''
        if(relation['color'] or relation['opacity']):
                particular_style = 'style="'
                if relation['color']: particular_style += 'fill: {}'.format(relation['color'])
                if relation['opacity']: particular_style += 'opacity: {}'.format(relation['opacity'])
                particular_style += '"'
        if(args.bezier):
            if(vertex1[1] > vertex2[1]): multipliers = [1,2,2,1]
            else: multipliers = [2,1,1,2]
            bezier_coor1 = [ vertex1[0], min(vertex1[1], vertex2[1]) + abs(vertex1[1] - vertex2[1])/3*multipliers[0] ]
            bezier_coor2 = [ vertex2[0], min(vertex1[1], vertex2[1]) + abs(vertex1[1] - vertex2[1])/3*multipliers[1] ]
            bezier_coor3 = [ vertex3[0], min(vertex3[1], vertex4[1]) + abs(vertex3[1] - vertex4[1])/3*multipliers[2] ]
            bezier_coor4 = [ vertex4[0], min(vertex3[1], vertex4[1]) + abs(vertex3[1] - vertex4[1])/3*multipliers[3] ]
            svg_content_align += '''<path d="M{},{} C{},{} {},{} {},{} L{},{} C{},{} {},{} {},{} Z" {} class="align"/>\n'''.format(vertex1[0], vertex1[1], bezier_coor1[0], bezier_coor1[1], bezier_coor2[0], bezier_coor2[1], vertex2[0], vertex2[1], vertex3[0], vertex3[1], bezier_coor3[0], bezier_coor3[1], bezier_coor4[0], bezier_coor4[1], vertex4[0], vertex4[1], particular_style)
        else:
            svg_content_align += '''<path d="M{},{} L{},{} L{},{} L{},{} Z" {} class="align"/>\n'''.format(vertex1[0], vertex1[1], vertex2[0], vertex2[1], vertex3[0], vertex3[1], vertex4[0], vertex4[1], particular_style)
    scale_x = args.svg_width*(1-args.svg_space/2)-L*scale;scale_y=args.svg_height*0.9
    svg_content_scale += '''<polyline points="{},{} {},{} {},{} {},{} " fill="none" stroke="black" class="scale"/>\n'''.format(scale_x,scale_y-5,scale_x,scale_y,scale_x+L*scale,scale_y,scale_x+L*scale,scale_y-5)
    svg_content_scale += '''<text x="{}" y="{}" fill="black"  font-size="{}" class="scale-text">{}</text>\n'''.format(scale_x+L*scale/3,scale_y-10,args.label_font_size,S)
    
    if(args.highlight):
        if not os.path.exists(args.highlight): raise ArgumentError('highlight',args.highlight)
        H = open(args.highlight,'r')
        for line in H:
            if line.startswith('#'): continue
            line = line.strip()
            items = re.split(r'\s+',line)
            if(len(items) >= 4): color = items[3]
            else: color = 'red'
            chro = items[0]
            start = int(items[1])
            end = int(items[2]) + 1
            if not chro in chro_lst: continue

            relation_tmp = interval.relation([start,end],[chro_lst[chro].start,chro_lst[chro].end])
            if relation_tmp == 1:
                continue
            elif relation_tmp == 2:
                start,end = interval.intersection([start,end],[chro_lst[chro].start,chro_lst[chro].end])
            svg_content_highlight += '''<rect x="{}" y="{}" width="{}" height="{}" fill="{}" />\n'''.format(chro_lst[chro].coordinate(start,is_up,is_start=True)[0],chro_lst[chro].top, chro_lst[chro].coordinate(end,is_up)[0]-chro_lst[chro].coordinate(start,is_up,is_start=True)[0],args.chro_thickness,color)
        H.close()


    svg_content = '<svg width="{}" height="{}" xmlns="http://www.w3.org/2000/svg" version="1.1">\n'.format(args.svg_width,args.svg_height)
    svg_content += (svg_content_style + svg_content_line + svg_content_chro + svg_content_label + svg_content_align + svg_content_scale + svg_content_highlight+svg_content_axis + svg_content_gene + svg_content_clipPath)
    svg_content += '</svg>\n'
    #=========================================================================

    print(svg_content)
    O = open(args.output+'.svg','w')
    O.write(svg_content)
    O.close()

#    os.system('inkscape --file {}.svg --export-png {}.png --export-background white --export-dpi 350'.format(args.output,args.output))   

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("input",help='The input file which contains location relationships. Can be a text file, format like: "chro1 start1 end1 chro2 start2 end2 color:opacity". It can also be a output file generated by blastn or nucmer.')
    parser.add_argument('-t','--type',default=0,type=int,help='''Type of input file, 0 for link.txt format like "chro1 start1 end1 chro2 start2 end2 color:opacity"; 
    1 for output file of blast format as "query subject identity alignment_length mismatches gap_opens q.start q.end s.start s.end evalue bit score"; 
    2 for output file of nucmer.\tdefault=0''')
    parser.add_argument('-hl','--highlight',help='highlight.txt, Highlight section, format like chr start end [color]')
    parser.add_argument('-k','--karyotype',help="Karyotype.txt, If you don't specify this file, it will automatically sort and display.format like chro1:[start1:end1] chro2...")
    parser.add_argument('--opacity',default=0.5,type=float,help='opacity, default=0.5')
    parser.add_argument('--color',default="green",type=str,help='color, default=green')
    parser.add_argument('--svg_height',default=800,type=int,help='height of svg, default=800')
    parser.add_argument('--svg_width',default=1200,type=int,help='width of svg, default=1200')
    parser.add_argument('--svg_space',default=0.2,type=float,help='The proportion of white space left and right, default=0.2')
    parser.add_argument('--chro_thickness',default=15,type=int,help='thickness of chromosome, default=15')
    parser.add_argument('-n','--no_label',action="store_true",help='Do not show labels')
    parser.add_argument('--label_font_size',default=18,type=int,help='font size of the label, default=18')
    parser.add_argument('--label_angle',default=0,type=int,help='label rotation angle, default=0')
    parser.add_argument('--chro_axis',action="store_true",help='Display the axis (only for the chromosomes at the top or bottom)')
    parser.add_argument('--chro_axis_density',default=2,type=int,help='It is useful for tuning the scale density. The higher the value, the denser the scale.')
    parser.add_argument('-s','--show_pos_with_label',action="store_true",help='Display location information on the label')
    parser.add_argument('--scale',help='example:5k default=auto')
    parser.add_argument('-o','--output',default="linkview_output",type=str,help='output file prefix, default=linkview_output')
    parser.add_argument('--min_identity',default=95,type=float,help='if your input file is a output file of blast or nucmer, the min_identy to filter the input file, default=95')
    parser.add_argument('--min_alignment_length',default=200,type=int,help='if your input file is a output file of blast or nucmer, the min_alignment_length to filter the input file, default=200')
    parser.add_argument('--max_evalue',default=1e-5,type=float,help='if your input file is a output file of blast, the max_evalue to filter the input file, default=1e-5')
    parser.add_argument('--min_bit_score',default=5000,type=float,help='if your input file is a output file of blast, the min_bit_score to filter the input file, default=5000')
    parser.add_argument('--gap_length',default=0.2,type=float,help='Length of gap between two segments per line,if > 1,It represents Physical length, if<1,It represents total_length_of_this_line * this. default=0.2')
    parser.add_argument('--chro_len',help='chro_len.txt, format as: chro1 150000')
    parser.add_argument('-p','--parameter',help='Specify the parameters for each row separately in a file, if needed. E.g label_font_size=20 show_pos_with_label=0 no_label=1 gap_length=500')
    parser.add_argument('-g','--gff',help='One or multiple gff files, Separated by commas. Required for mapping genetic structures.')
    parser.add_argument('--bezier',action="store_true",help='Draw in Bezier style')
    parser.add_argument('--style', default='classic', help='Drawing style, we have two built-in styles: classic, simple. default=classic')
    
    
    args=parser.parse_args()
    if args.label_angle:args.label_angle = 360-float(args.label_angle)

    main(args)

