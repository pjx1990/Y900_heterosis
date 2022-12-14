#conda activate maker
export LIBDIR=/ifs1/User/pengjx/biosoft/RepeatMasker/Libraries
mpiexec -n 20 maker &> maker.log &
