source /etc/profile.d/modules.sh

set -x

echo y | module clear
#module load mkl anaconda
module load anaconda

export PREFIX=/opt/apps/amber/amber16-gcc-openmpi

unset FFLAGS
CFLAGS="-O2 -ggdb -pipe -march=native -ftree-vectorize -ftree-slp-vectorize -fvect-cost-model"
CXXFLAGS="${CFLAGS}"
FFLAGS="${CFLAGS}"
FCFLAGS="${FFLAGS}"
export CFLAGS CXXFLAGS FFLAGS FCFLAGS
