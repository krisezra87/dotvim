#!/bin/bash
shopt -s dotglob

# Get the directory of this file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ $DIR == ~/.vim ]; then
    echo ".vim is properly located"
else
    if [ -d ~/.vim ]; then
        mv ~/.vim ~/.vim.old
    fi
fi

mkdir -p ~/.vim
mv $DIR/* ~/.vim/

cd ~/.vim

echo "source ~/.vim/.bash_vim" >> ~/.bashrc

# Set up the submodules (Vundle)
git submodule init
git submodule update --remote

# Set up plugin list
vim +PluginInstall +qall
