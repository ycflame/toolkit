#!/usr/bin/env bash

git submodule init
git submodule update
cp ~/.vimrc{,.bak}
cp vimrc ~/.vimrc
rsync -avzhu --delete-excluded --exclude $1 '.git' vim/ ~/.vim/
cp templates/* ~/.vim/bundle/vim-template/templates
