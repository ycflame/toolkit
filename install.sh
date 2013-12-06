#!/usr/bin/env bash

cp ~/.vimrc{,.bak}
cp vimrc ~/.vimrc
rsync -rtvu --exclude $1 '.git' vim/ ~/.vim/
