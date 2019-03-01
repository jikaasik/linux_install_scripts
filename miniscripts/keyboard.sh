#!/bin/bash

mkdir ~/.config/.keyboard
curl https://raw.githubusercontent.com/jikaasik/dotfiles/master/keyboard/remap > ~/.config/.keyboard/remap
chmod +x ~/.config/.keyboard/remap

