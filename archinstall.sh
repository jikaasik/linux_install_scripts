#!/bin/bash

# This is a script to install Arch Linux. 
# The installer assumes you have 7 partitions: 
# /dev/sda1, with EFI system partition (esp) and boot flags
# /dev/sda2, formatted as linux-swap
# /dev/sda3, which will be the root partition
# /dev/sda4, which will be the home partition
# /dev/sda5, which will be a work partition
# /dev/sda6, which will be a media partition
# /dev/sda7, which will be an archive partition

# partition and mount
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda3 -F
mkfs.ext4 /dev/sda4 -F

swapon /dev/sda2

mkdir /mnt/install
mount /dev/sda3 /mnt/install 

mkdir /mnt/install/boot
mount /dev/sda1 /mnt/install/boot

mkdir /mnt/install/home
mount /dev/sda4 /mnt/install/home

mkdir /mnt/install/archive
mount /dev/sda7 /mnt/install/archive

mkdir /mnt/install/work
mount /dev/sda5 /mnt/install/work

mkdir /mnt/install/media
mount /dev/sda6 /mnt/install/media

# rank mirrors
# cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

# sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup

# rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# install base packages
pacstrap /mnt/install base base-devel

# generate fstab
genfstab -U /mnt/install >> /mnt/install/etc/fstab

# mulilib mirrors
echo -e "\n[multilib] \nInclude = /etc/pacman.d/mirrorlist" >> /mnt/install/etc/pacman.conf

# AUR
echo -e "\n[archlinuxfr] \nServer = http://repo.archlinux.fr/\$arch \nSigLevel = Never" >> /mnt/install/etc/pacman.conf

# CHROOT
curl https://raw.githubusercontent.com/jikaasik/arch_installer/master/chroot.sh > /mnt/install/chroot.sh && arch-chroot /mnt/install bash chroot.sh && rm /mnt/install/chroot.sh

#cat chroot.sh > /mnt/install/chroot.sh && arch-chroot /mnt/install bash chroot.sh && rm /mnt/install/chroot.sh

umount -R /mnt/install





