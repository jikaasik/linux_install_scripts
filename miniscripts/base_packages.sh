#!/bin/bash

# Base packages
pacman -S --noconfirm base-devel xf86-input-synaptics mesa sudo xf86-video-intel xorg-server xorg-apps xorg-xinit 
xorg-twm xorg-xclock xterm git lib32-mesa

# i3
pacman -S i3 

# Display manager
pacman -S --noconfirm sddm
systemctp enable sddm.service

#Network
pacman -S --noconfirm networkmanager nm-connection-editor
systemctl enable NetworkManager
