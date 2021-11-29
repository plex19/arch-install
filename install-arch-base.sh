#!/bin/bash 

#load keyboardlayout
loadkeys de-latin1

#Disk Setup - boot, 512Mb, ef00 - swap, 4Gb, 8200 - home, 100Gb, 8300 - root, 150Gb, 8300
fdisk -l 
fdisk /dev/sda
o #create empty partitiontable (cache)
n #create new partition
p #show partitions before save
1 #partitionno.
2048 #first sector
+512M #last sector, +/- Größe


#format datasystem
mkfs.fat -F 32 -n BOOT /dev/xY #use for UEFI-Install
#mkfs.fat -F 32 -n EF02 /dev/xY #use for Bios-Install
mkfs.ext4 -L ROOT /dev/xY # 
mkfs.ext4 -L HOME /dev/xY #
mkswap -L SWAP /dev/xY #

#mount partitions
mount -L ROOT /mnt
mkdir /mnt/boot
mount -L BOOT /mnt/boot
mkdir /mnt/home
mount -L HOME /mnt/home
swapon -L SWAP

#installation basic packages
pacstrap /mnt base base-devel linux linux-firmware dhcpcd nano amd-ucode

#fstab - mount disks automaticly 
genfstab -U /mnt > /mnt/etc/fstab
cat /mnt/etc/fstab

#systemconfig
arch-chroot /mnt
echo arch > /etc/hostname
echo LANG=de_AT.UTF-8 > /etc/locale.conf

nano /etc/locale.gen
#uncomment following lines for AT location
#de_DE.UTF-8 UTF-8
#de_DE ISO-8859-1
#de_DE@euro ISO-8859-15
#en_US.UTF-8

locale-gen
echo KEYMAP=de-latin1 > /etc/vconsole.conf
echo FONT=lat9w-16 >> /etc/vconsole.conf

ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime

cat /etc/hosts
echo #<ip-address>	<hostname.domain.org>	<hostname> >> /etc/hosts
echo 127.0.0.1	localhost.localdomain	localhost >> /etc/hosts
echo ::1		localhost.localdomain	localhost >> /etc/hosts

#/etc/pacman.conf
#[multilib]
#SigLevel = PackageRequired TrustedOnly
#Include = /etc/pacman.d/mirrorlist


nano /etc/modules-load.d/meinemodule.conf

mkinitcpio -p linux

echo root:password | chpasswd

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch-Linux

#custom options for Grub
echo menuentry "System reboot" { >> /etc/grub.d/40_custom
echo echo "System rebooting..." { >> /etc/grub.d/40_custom
echo reboot { >> /etc/grub.d/40_custom
echo } { >> /etc/grub.d/40_custom

echo menuentry "System shutdown" { >> /etc/grub.d/40_custom
echo echo "System shutting down..." { >> /etc/grub.d/40_custom
echo halt { >> /etc/grub.d/40_custom
echo } { >> /etc/grub.d/40_custom

grub-mkconfig -o /boot/grub/grub.cfg

#reboot
exit
umount /mnt/boot
umount /mnt
reboot




