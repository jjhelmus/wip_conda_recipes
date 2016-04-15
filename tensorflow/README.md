## Notes on building tensorflow wheels and conda package using Docker

### Instructions for building wheel files.

docker build -t test -f Dockerfile .
docker run --privileged -t -i test /bin/bash

```
export PATH=/opt/conda/bin:$PATH
conda create -n py27 python=2.7 swig wheel numpy
source activate py27
git clone --recurse-submodules -b v0.8.0rc0 https://github.com/tensorflow/tensorflow
cd tensorflow/
./configure
bazel build -c opt //tensorflow/tools/pip_package:build_pip_package
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
# repeat for other version of Python
```

### Instructions for building conda packages.

docker build -t test -f Dockerfile .
docker run --privileged -v `pwd`:/recipe -t -i test /bin/bash

In the docker container run:

```
export PATH=/opt/conda/bin:$PATH
cd /recipe/
conda build --python 2.7 -c jjhelmus .
conda build --python 3.4 -c jjhelmus .
conda build --python 3.5 -c jjhelmus .
anaconda upload /opt/conda/conda-bld/linux-64/tensorflow*.bz2
```

## In progress CentOS5 Docker image

The Dockerfile_centos5 file is an in works Docker image based on CentOS 5.
It currently can not be used to build tensorflow.

The image in Dockerfile is based on Ubuntu 14.04.
