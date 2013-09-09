#!/bin/bash

cp vimrc ~/.vimrc
rsync -rtvu --delete --exclude '.git' vim/ ~/.vim/
