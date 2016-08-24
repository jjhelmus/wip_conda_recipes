#!/bin/bash

# install bazel
curl -s -L -O https://github.com/bazelbuild/bazel/archive/0.3.1.tar.gz
tar xf 0.3.1.tar.gz
cd bazel-0.3.1

# compile
./compile.sh

mkdir -p ~/bin
cp output/bazel ~/bin/

cd ..

# Set up symlinks to python include normally performed by ./configure
export PYTHON_BIN_PATH=$PREFIX/bin/python
(./util/python/python_config.sh --setup "$PYTHON_BIN_PATH";) || exit -1

# Use conda installed swig
# http://stackoverflow.com/questions/33885276
echo "#!/bin/bash" > tensorflow/tools/swig/swig.sh
echo "`which swig` \"\$@\"" >> tensorflow/tools/swig/swig.sh
cat tensorflow/tools/swig/swig.sh

# build wheel using bazel
bazel build -c opt //tensorflow/tools/pip_package:build_pip_package
mkdir $SRC_DIR/tensorflow_pkg
bazel-bin/tensorflow/tools/pip_package/build_pip_package $SRC_DIR/tensorflow_pkg

# install using pip from the whl file
pip install --no-deps $SRC_DIR/tensorflow_pkg/*.whl
