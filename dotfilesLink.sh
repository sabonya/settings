#!/bin/sh
# assumes to execute at this directory
DIR=`pwd`
ln -f $DIR/.vimrc ~/.vimrc
ln -f $DIR/.bashrc ~/.bashrc
ln -f $DIR/.gitconfig ~/.gitconfig
ln -f $DIR/gitignore_global.txt ~/gitignore_global.txt
