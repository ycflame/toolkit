#!/usr/bin/env bash

sudo pip install -r requirements.txt
git submodule init
git submodule update
cp ~/.vimrc{,.bak}
cp vimrc ~/.vimrc
rsync -avzhu --filter='P *.pyc' --delete-excluded --exclude $1 '.git' vim/ ~/.vim/
cp templates/* ~/.vim/bundle/vim-template/templates
mkdir -p ~/.trash
