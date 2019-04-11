#!/bin/bash

# Set up the submodules (Vundle)
git submodule init
git submodule update --remote

# Set up plugin list
vim +PluginInstall +qall
