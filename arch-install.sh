#!/bin/bash
#install archfile

#---------Variable------------------

wmess="Welcome to the Arch Linux Bash Installation Menu"
mess1="This Script will help you to install Arch Linux with a Menu or easy Instructions"
entrys="loadKeysDE update upgrade install"
keysDE="loadkeys de-latin1"
pac="gedit"
#---------Functions-----------------

installArch()
{
 local installArch
 echo "Do you want to install Arch Linux on your System ?"
 echo "y - continue Script	n - exit Script"
 echo "Please Press y or n on your Keyboard"
 read installArch
 case $installArch in
	y|yes|Yes)	echo "selected $REPLY - $installArch"
		 	menu 
			;;
	n|no|No|*)	echo "selected $REPLY - $installArch"
		 	exit 0
			;;	
 esac
}

menu()
{
 echo "Select Menu Option"
# select option in $entrys; do
#	case $option in 
#		loadKeysDE)	echo "Selected $REPLY - $option";
#				$keysDE
#				;;
#		*)		;;
#	esac
}
#---------Calls---------------------

#echo $wmess
#echo $mess1
installArch
