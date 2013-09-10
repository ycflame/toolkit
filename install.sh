#!/usr/bin/env zsh

add_to_path ()
{
    if [[ "$PATH" =~ (^|:)"${1}"(:|$) ]]
    then
        return 0
    fi
    echo "export PATH=$PATH:${1}" >> ~/.zshrc
    source ~/.zshrc
}

tool_path=$(pwd)/bin
add_to_path $tool_path

cp vimrc ~/.vimrc
rsync -rtvu --exclude '.git' vim/ ~/.vim/
