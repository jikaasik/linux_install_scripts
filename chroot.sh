#!/bin/bash

# This is a script to install Arch Linux.

passwd 

# set timezone
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

hwclock --systohc

# set locale and language
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen




# update pacman
pacman -Sy

# network manager
pacman --noconfirm --needed -S networkmanager nm-connection-editor
systemctl enable NetworkManager
systemctl start NetworkManager

pacman --noconfirm --needed -S xf86-input-synaptics dialog sudo mesa xf86-video-intel lib32-mesa xorg-server xorg-apps xorg-xinit xorg-twm xorg-xclock xterm efibootmgr git
pacman --noconfirm --needed -S i3

# display manager
pacman --noconfirm --needed -S lightdm
systemctl enable lightdm.service

# set hostname
hostname=$(dialog --no-cancel --inputbox "Choose a hostname." 10 60 3>&1 1>&2 2>&3 3>&1)
echo "$hostname" > /etc/hostname

# create user
username=$(dialog --no-cancel --inputbox "Choose a username." 10 60 3>&1 1>&2 2>&3 3>&1)
pass1=$(dialog --no-cancel --passwordbox "Choose a password." 10 60 3>&1 1>&2 2>&3 3>&1)
pass2=$(dialog --no-cancel --passwordbox "Repeat password." 10 60 3>&1 1>&2 2>&3 3>&1)

while [ $pass1 != $pass2 ]
do
	pass1=$(dialog --no-cancel --passwordbox "Password mismatch. Try again" 10 60 3>&1 1>&2 2>&3 3>&1)
	pass2=$(dialog --no-cancel --passwordbox "Repeat password." 10 60 3>&1 1>&2 2>&3 3>&1)
	unset pass2
done

dialog --infobox "Adding user \"$username\"..." 4 50
useradd -m -g wheel -s /bin/bash $username >/dev/tty6
echo "$username:$pass1" | chpasswd >/dev/tty6

# User privileges
echo -e "root ALL=(ALL) ALL" >> /etc/sudoers
echo -e "wheel ALL=(ALL) ALL" >> /etc/sudoers

chmod -R 777 /archive
chmod -R 777 /media
chmod -R 777 /work

# Audio and Bluetooth 
pacman -S pulseaudio pulseaudio-alsa bluez bluez-utils pulseaudio-bluetooth

# Bootloader
bootctl --path=/boot install
rm -rf /boot/loader/loader.conf
echo -e "default arch\ntimeout 4\neditor no" > /boot/loader/loader.conf
echo -e "title Archlinux \nlinux /vmlinuz-linux \ninitrd /initramfs-linux.img \noptions root=UUID=$(blkid -o value -s UUID /dev/sda3)" > /boot/loader/entries/arch.conf
