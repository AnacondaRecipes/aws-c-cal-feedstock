#!/bin/bash

set -ex

mkdir build
pushd build

EXTRA_CMAKE_ARGS=""

if [[ ${target_platform} == linux-* ]]; then
  EXTRA_CMAKE_ARGS="${EXTRA_CMAKE_ARGS} -DUSE_OPENSSL=ON"
fi

cmake ${CMAKE_ARGS} -GNinja \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DENABLE_TESTING=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  ${EXTRA_CMAKE_ARGS} \
  ..

cmake --build . --config Release --target install

ctest --output-on-failure -j${CPU_COUNT}
popd
