#!/bin/bash

export BLAS_LAPACK_LIB_PATHS=$PREFIX/lib
if [ "$(uname)" == "Linux" ]; then
    export CVXOPT_BLAS_LIB=openblas
    export CVXOPT_LAPACK_LIB=openblas
    export CVXOPT_BLAS_EXTRA_LINK_ARGS=-lgfortran
fi
export CFLAGS="-I$PREFIX/include -L$PREFIX/lib"
CVXOPT_BUILD_GLPK=1 ${PYTHON} setup.py install
