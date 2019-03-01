#!/bin/bash

# i3 config
cd ~/.config
rm -rf ~/.config/i3/config
curl https://raw.githubusercontent.com/jikaasik/dotfiles/master/i3/config > ~/.config/i3/config

# screen layout
mkdir .screenlayout $$ curl https://raw.githubusercontent.com/jikaasik/dotfiles/master/screenlayout/default.sh > ~/.config/.screenlayout/default.sh

# keyboard
mkdir .keyboard $$ curl https://raw.githubusercontent.com/jikaasik/dotfiles/master/keyboard/remap > ~/.config/.keyboard/remap

exit
