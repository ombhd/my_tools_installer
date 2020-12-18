#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

get_conf()
{
 	while true; do
		if [[ $2 == 0 ]]; then
			echo -en "\n\033[33m$1 is not installed in goinfre\n\033[0m"
			echo -en "\033[33mDo you want to install $1 in goinfre ? \033[0m"
		else
			echo -en "\n\033[33mDo you want to install $1 ? \033[0m"
		fi
		read -r confirmation
		case $confirmation in
			[Yy]* ) confirmation=1 && break;;
			[Nn]* ) confirmation=0 && break;;
			* ) echo -e "\nPlease answer yes or no !";;
		esac
	done
}

confirmation=0
is_installed=$(which "$1" &>/dev/null; echo -n $?)
path=$(which "$1")

if [[ "$is_installed" == "0" && "$path" != *"goinfre"* ]]; then
	get_conf "$1" 0
	if [ "$confirmation" == "1" ]; then
		echo -en "\n\033[33mPlease, remove your version of $1 (remove the whole directories of $1)\033[0m\n"
		sleep 2
	fi

elif [ "$is_installed" == "1" ]; then
	get_conf "$1" 1

else
	if [[ "$1" == "brew" && "$is_installed" == "0" && "$path" == *"goinfre"* ]]; then
		echo -e "\n\033[32m------- brew has been already installed in goinfre -------\033[0m\n"
	else
		echo -e "\n\033[32m------- $1 has been already installed -------\033[0m\n"
	fi
	sleep 1
	exit 2

fi
exit $confirmation