#!/bin/bash
shopt -s dotglob

# Get the directory of this file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
mkdir -p ~/.vim
mv $DIR/* ~/.vim/

cd ~/.vim

# Set up the submodules (Vundle)
git submodule init
git submodule update --remote

# Set up plugin list
vim +PluginInstall +qall
