#!/usr/bin/env bash

# Modified from Youtube Vim as Python IDE - Martin Brochhaus at approx. 8:52
# Set up a local vim install

cd ~
git clone https://github.com/vim/vim.git

PYDIR=`readlink -f $(which python3)`
OPTDIR=`echo ${PYDIR%bin*}`
LIBDIR=`find $OPTDIR -name "lib"`
CONFIGDIR=`find $LIBDIR -type d -name config*`

cd vim/src

./configure --with-features=huge --enable-multibyte --enable-python3interp=yes --with-python3-config-dir=$CONFIGDIR --enable-cscope --prefix=$HOME/opt/vim

unset PYDIR
unset OPTDIR
unset LIBDIR
unset CONFIGDIR

#./configure --with-features=huge --enable-multibyte --prefix=$HOME/opt/vim
make && make install

mkdir -p $HOME/bin
cd $HOME/bin

ln -s $HOME/opt/vim/bin/vim

# Check the version information
vim --version
