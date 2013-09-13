#!/usr/bin/env bash

cp vimrc ~/.vimrc
rsync -rtvu --exclude '.git' vim/ ~/.vim/
