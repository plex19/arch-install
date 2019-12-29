#!/bin/bash
#install archfile

#TODO 
# partition mkfs mount network installArch fstab
# 2nd build configfile arch-config.sh
#---------Variable------------------

wmess="Welcome to the Arch Linux Bash Installation Menu"
mess1="This Script will help you to install Arch Linux with a Menu or easy Instructions"
entrys="loadKeysDE update install"
keysDE="loadkeys de-latin1"
pac="gedit"
del="-------------------------------------------------------"
selop="selected"
#---------Functions-----------------

installArch()
{
 local installArch
 echo "Do you want to continue installation of  Arch Linux on your System ?"
 echo $del
 echo "y - continue Script	n - abort Script"
 echo $del
 echo "Please Press y or n on your Keyboard"
 echo "!!!Remind only RETURN will determinate script!!!"
 echo $del
 read installArch
 case $installArch in
	y|yes|Yes)
			echo "selected $REPLY - $installArch"
		 	echo $del
			menu 
			;;
	n|no|No|*)
			echo "selected $REPLY - $installArch"
		 	echo "Script abort"
			echo $del
			exit 0
			;;	
 esac
}

menu()
{
 echo "Select Menu Option"
 echo $del
 select option in $entrys
 do 
 case $option in
 loadKeysDE)		echo "$selop $option"
			$keysDE
			;;
 update)		echo "$selop $option"
			sudo pacman -Syu
			;;
 install)		echo "$selop $option"
			sudo pacstrap /mnt base base-devel linux linux-firmware bash-completion
			;;
 *)			echo "invalid option"
			installArch
			;;	
 esac
 done
}
#---------Calls---------------------

#echo $wmess
#echo $mess1
installArch
