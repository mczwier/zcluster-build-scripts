#!/bin/bash

function do_build() {
    PREPEND_PATH="$1"        
    (
        if [[ -n $PREPEND_PATH ]] ; then
            export PATH="$PREPEND_PATH:$PATH"
        fi
        source amber.sh
        make -j32 install || make -1 install
    ) && make clean
}

do_configure() {
  PREPEND_PATH="$1"; shift
  export PATH="$PREPEND_PATH:$PATH"
  ./configure "$@"
}

source ../env.sh

export AMBERHOME=$PWD
export CUDA_HOME=/opt/cuda
export MKL_HOME=$MKLROOT

# Clean out prior work
make distclean

set -e

# Apply patches
./update_amber --update

# Configure and build serial
./configure intel
do_build 

# Configure and build parallel
#./configure -mpi intel
do_configure $PREFIX/bin -mpi intel
do_build $PREFIX/bin

# Configure and build cuda
#./configure -cuda intel
do_configure $PREFIX/bin -cuda intel
do_build $PREFIX/bin

# install
rsync -av * $PREFIX/

