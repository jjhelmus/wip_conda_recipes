#!/usr/bin/env bash
set -x

# install and update Miniconda
cp /vagrant/vendor/Miniconda-latest-Linux-x86_64.sh .
chmod +x Miniconda-latest-Linux-x86_64.sh
./Miniconda-latest-Linux-x86_64.sh -b
export PATH=/home/vagrant/miniconda2/bin:$PATH
echo "export PATH=/home/vagrant/miniconda2/bin:\$PATH " >> ~/.bashrc;
conda update --yes conda
conda install --yes conda-build jinja2
