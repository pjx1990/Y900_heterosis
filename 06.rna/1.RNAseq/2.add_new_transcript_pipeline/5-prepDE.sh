## wget  http://ccb.jhu.edu/software/stringtie/dl/prepDE.py
#python2 ./prepDE.py -i ballgown #-l 150
python2 ./getFPKM.py -i ballgown 
python2 ./getTPM.py -i ballgown 
