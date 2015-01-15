#!/bin/bash

source /etc/profile.d/modules.sh

export CC=gcc-4.9.2
export CXX=g++-4.9.2
module unload intel
module unload mkl

PREFIX=/opt/apps/gromacs/gromacs-4.6.7-gcc

rm -Rf build
mkdir build
pushd build
  set -e
    cmake .. -DGMX_GPU=OFF -DGMX_BUILD_OWN_FFTW=ON -DCMAKE_INSTALL_PREFIX=$PREFIX
    make -j32 || make
    make install 
  set +e
popd # build
