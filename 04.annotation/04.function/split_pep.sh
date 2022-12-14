sed 's/ .*//g' /ifs1/User/pengjx/project/Rice/06.annotation/final/R900/R900.pep.fa >protein.fa
sed -i 's/*//g' protein.fa
pyfasta split -n 25 protein.fa  #split 25份
#sed -i  '/>OsR900g17645.t1/d;/>OsR900g31239.t1/d;/^$/d' protein.fa
