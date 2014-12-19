source /etc/profile.d/modules.sh

set -x

echo y | module clear
module load intel mkl

export PREFIX=/opt/apps/amber/amber14-intel-openmpi

CC=icc
CXX=icpc
FC=ifort
F77=ifort
F90=ifort
F95=ifort
export CC CXX FC F77 F90 F95

unset FFLAGS
CFLAGS="-xHOST -O3"
CXXFLAGS="${CFLAGS}"
FFLAGS="${CFLAGS}"
FCFLAGS="${FFLAGS}"
export CFLAGS CXXFLAGS FFLAGS FCFLAGS
