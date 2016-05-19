#!/bin/bash

set -e
pushd openmpi-1.10.2
  ./build.sh
popd
pushd xianyi-OpenBLAS-12ab180
  ./build.sh
popd
pushd amber16
  ./build.sh
popd

