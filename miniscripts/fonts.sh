#!/bin/bash

# fonts
cd ~/Downloads
mkdir ~/.fonts
wget https://github.com/jikaasik/dotfiles/archive/master.zip -L
unzip master.zip
cp dotfiles-master/fonts/* ~/.fonts/
rm -rf dotfiles-master master.zip


