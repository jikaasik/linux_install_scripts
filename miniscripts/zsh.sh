#!/bin/bash

pacman -S --noconfirm zsh

mkdir /home/jikaasik/.config/fontconfig -p
curl https://raw.githubusercontent.com/powerline/fonts/master/fontconfig/50-enable-terminess-powerline.conf > ~/.config/fontconfig/conf.d

curl https://raw.githubusercontent.com/jikaasik/dotfiles/master/.zshrc > ~/.zshrc
