#!/bin/bash
#configure DPM - Dynamic Power Management by Plex_19
#Tested on Arch Linux - Navi 10 GPU

#TODO 

#---------Variable------------------

wmess="Welcome to Dynamic Power Management Menu"
mess1="This Script let you change the power consumption and performance"
del="-------------------------------------------------------"
selop="selected"
powermenuentrys="battery balanced performance show_config test"
testmenuentrys="low high auto show_config"
#---------Functions-----------------

continueScript()
{
 local continueScript
 echo "Do you want to change the GPU powerconsumption and performance of your System ?"
 echo $del
 echo "y - continue Script	n - abort Script"
 echo $del
 echo "Please Press y or n on your Keyboard"
 echo "!!!Remind only RETURN will determinate script!!!"
 echo $del
 read continueScript
 case $continueScript in
	y|yes|Yes)
			echo "selected $REPLY - $continueScript"
		 	echo $del
			powermenu
			;;
	n|no|No|*)
			echo "selected $REPLY - $continueScript"
		 	echo "Script abort"
			echo $del
			exit 0
			;;	
 esac
}

powermenu()
{
 echo "Select Power Menu Option"
 echo $del
 select option in $powermenuentrys
 do 
 case $option in
 battery)		echo "$selop $option"
			sudo echo battery > /sys/class/drm/card0/device/power_dpm_state
			;;
 balanced)		echo "$selop $option"
			sudo echo balanced > /sys/class/drm/card0/device/power_dpm_state
			;;
 performance)		echo "$selop $option"
			sudo echo performance > /sys/class/drm/card0/device/power_dpm_state
			;;
 show_config)		echo "$selop $option"
			sudo cat /sys/class/drm/card0/device/power_dpm_state
			;;

 test)			echo "$selop $option"
			echo "test the card by force into performance mode"
			testmenu
			;; 
 *)			echo "invalid option"
			continueScript
			;;	
 esac
 done
 echo $del
}


testmenu()
{
 echo "Select Test Menu Option"
 echo $del
 select option in $testmenuentrys
 do 
 case $option in
 low)		echo "$selop $option"
			sudo echo low > /sys/class/drm/card0/device/power_dpm_force_performance_level
			;;
 high)		echo "$selop $option"
			sudo echo high > /sys/class/drm/card0/device/power_dpm_force_performance_level
			;;
 auto)			echo "$selop $option"
			sudo echo auto > /sys/class/drm/card0/device/power_dpm_force_performance_level
			;;	
 show_config)		echo "$selop $option"
			sudo cat /sys/class/drm/card0/device/power_dpm_force_performance_level
			;;
 *)			echo "invalid option"
			continueScript
			;;
			
 esac
 done
}
#---------Calls---------------------

#echo $wmess
#echo $mess1
continueScript
powermenu
