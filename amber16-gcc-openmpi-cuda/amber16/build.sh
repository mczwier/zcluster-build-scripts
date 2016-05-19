#!/bin/bash

BUILDSYS=gnu
#EXTRA_CONFIG_ARGS="--with-netcdf /usr"
EXTRA_CONFIG_ARGS=""

function do_build() {
    PREPEND_PATH="$1"        
    (
        if [[ -n $PREPEND_PATH ]] ; then
            export PATH="$PREPEND_PATH:$PATH"
        fi
        source amber.sh
        make -j32 install || make install
    ) 
}

do_configure() {
  PREPEND_PATH="$1"; shift
  export PATH="$PREPEND_PATH:$PATH"
  ./configure $EXTRA_CONFIG_ARGS "$@"
}

source ../env.sh

export AMBERHOME=$PWD
export CUDA_HOME=/opt/cuda
export GOTO=$PREFIX/lib/libopenblas.a

# Clean out prior work
make distclean

set -e
set -x

# Apply patches
./update_amber --update

# Configure and build serial
./configure $EXTRA_CONFIG_ARGS $BUILDSYS 
do_build 

# Configure and build parallel
#./configure -mpi intel
do_configure $PREFIX/bin -mpi $BUILDSYS
do_build $PREFIX/bin

# Configure and build cuda
#./configure -cuda intel
do_configure $PREFIX/bin -cuda $BUILDSYS
do_build $PREFIX/bin

# install
rsync -av * $PREFIX/

