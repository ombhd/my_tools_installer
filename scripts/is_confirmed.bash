#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

get_conf()
{
 	while true; do
		echo -en "\n\033[33m --- $1 ? \033[0m"
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

if [[ -f "$HOME"/goinfre/.brew/bin/"$1" ]]; then
	confirmation=0

elif [ "$is_installed" == "1" ]; then
	get_conf "$1" 1

else
	if [[ "$1" == "brew" && "$is_installed" == "0" && "$path" == *"goinfre"* ]]; then
		echo -e "\n\033[32m------- brew has been already installed in goinfre -------\033[0m\n"
	else
	echo -e "\n\033[32m------- $1 is already installed -------\033[0m\n"
	fi
	sleep 1
	exit 2

fi

exit $confirmation
