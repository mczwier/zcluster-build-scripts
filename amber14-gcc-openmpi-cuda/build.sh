#!/bin/bash

set -e
pushd openmpi-1.10.2
  ./build.sh
popd
pushd xianyi-OpenBLAS-12ab180
  ./build.sh
popd
pushd amber14
  ./build.sh
popd

