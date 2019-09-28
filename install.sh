#!/bin/bash
echo "Running .vim installer..."

# Don't need detached head nonsense
git checkout master
OLD=$(pwd)

shopt -s dotglob

# Get the directory of this file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ $DIR == ~/.vim ]; then
    echo ".vim is properly located"
else
    if [ -d ~/.vim ]; then
        mv ~/.vim ~/.vim.old
    fi
    mkdir -p ~/.vim
    mv $DIR/* ~/.vim/
    rmdir $DIR
fi

cd ~/.vim
git checkout master
cd $OLD

# Legacy bash compatibility
if [ $SHELL = /usr/bin/bash ]
    echo "source ~/.vim/.shell_vim" >> ~/.bashrc
fi
