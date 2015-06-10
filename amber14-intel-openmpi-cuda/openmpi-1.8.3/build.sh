#!/bin/bash

source ../env.sh

set -e

./configure --prefix=$PREFIX --enable-shared --enable-static --enable-builtin-atomics --with-cuda=/opt/cuda --with-slurm
make -j32 || make
make install
