#!/bin/bash

# This script installs some basic packages and my i3 rice.

pacman -S --noconfirm ranger rofi nitrogen feh evince compton git geany wget unzip lxappearance arc-gtk-theme imagemagick python-pywal fcron keepass

pacman -S --noconfirm texlive-most r isync msmtp zsh powerline-fonts gnupg gcc-fortran gzip adobe-source-code-pro-fonts pandoc auctex mutt emacs vim rxvt-unicode xorg-xmodmap pdfpc

# AUR
git clone https://github.com/polygamma/aurman.git /tmp/aurman && cd /tmp/aurman && makepkg -si --skippgpcheck
aurman -S --noconfirm --noedit pacli

# fonts & polybar
sudo -u jikaasik bash << EOF

aurman -S polybar-git

# lock screen
aurman -S betterlockscreen-git
betterlockscreen -u /archive/pictures/train.jpg

# lightdm
aurman -S lightdm-webkit2-greeter lightdm-webkit-theme-litarvan

#zshell 
chsh -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

curl https://raw.githubusercontent.com/powerline/fonts/master/fontconfig/50-enable-terminess-powerline.conf > ~/.config/fontconfig/conf.d


# config
cd ~/.config
rm -rf ~/.config/i3/config
curl https://raw.githubusercontent.com/jikaasik/dotfiles/master/i3/config > ~/.config/i3/config

# screen layout
mkdir ~/.screenlayout
curl https://raw.githubusercontent.com/jikaasik/dotfiles/master/screenlayout/default.sh > ~/.config/.screenlayout/default.sh
chmod +x ~/.config/.screenlayout/default.sh

# keyboard
mkdir .keyboard
curl https://raw.githubusercontent.com/jikaasik/dotfiles/master/keyboard/remap > ~/.config/.keyboard/remap
chmod +x ~/.config/.keyboard/remap

# appearance
curl https://raw.githubusercontent.com/jikaasik/dotfiles/master/compton/compton.conf > ~/.config/compton.conf
curl https://raw.githubusercontent.com/jikaasik/dotfiles/master/.Xresources > ~/.Xresources

# fonts
cd ~/Downloads
mkdir ~/.fonts
wget https://github.com/jikaasik/dotfiles/archive/master.zip -L
unzip master.zip
cp dotfiles-master/fonts/* ~/.fonts/
rm -rf dotfiles-master master.zip

# emacs
git clone https://github.com/jikaasik/emacs.git ~/.emacs.d
EOF

# finish lightdm
rm -rf /etc/lightdm/lightdm-webkit2-greeter.conf
rm -rf /etc/lightdm/lightdm.conf
curl https://raw.githubusercontent.git/jikaasik/dotfiles/lightdm/lightdm-webkit2-greeter.conf > /etc/lightdm/lightdm-webkit2-greeter.conf
curl https://raw.githubusercontent.git/jikaasik/dotfiles/lightdm/lightdm.conf > /etc/lightdm/lightdm.conf

# libgthread-2.0.so.0 libncurses.so.5 tk 
