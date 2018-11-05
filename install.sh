#!/usr/bin/env bash

pip3 install -r requirements.txt --user
git submodule init
git submodule update
cp ~/.vimrc{,.bak}
cp config/vimrc ~/.vimrc
rsync -avzhu --filter='P *.pyc' --delete-excluded --exclude $1 '.git' vim/ ~/.vim/
cp templates/* ~/.vim/bundle/vim-template/templates
mkdir -p ~/.trash
