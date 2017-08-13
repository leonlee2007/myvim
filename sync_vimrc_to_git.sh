#!/bin/sh
cp ~/.vimrc ./vimrc
echo "copy .vimrc to ./vimrc"
git commit vimrc -m "update vimrc"
echo "vimrc commited"
git push
echo "=====================>>>>>>>>>>>>"
echo "vimrc pushed"

