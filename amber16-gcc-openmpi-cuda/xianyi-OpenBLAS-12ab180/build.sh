#!/bin/bash

source ../env.sh

unset CFLAGS CXXFLAGS FFLAGS FCFLAGS

make -i clean
make USE_THREAD=0
make PREFIX=$PREFIX install

