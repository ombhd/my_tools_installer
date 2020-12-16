#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

if [[ $1 == "question" ]]; then
	is_installed=$(which htop &>/dev/null; echo -n $?)
	path=$(which htop)

	if [[ "$is_installed" == "0" && "$path" != *"goinfre"* ]]; then

		while true; do
			echo -en "\n\033[33mhtop is not installed in goinfre\n\033[0m"
			echo -en "\033[33mDo you want to install htop in goinfre ? \033[0m"
			read -r htp
			case $htp in
				[Yy]* ) htp=1 && break;;
				[Nn]* ) htp=0 && break;;
				* ) echo -e "\nPlease answer yes or no !";;
			esac
		done
		if [ "$htp" == "1" ]; then
			echo -en "\n\033[33mPlease, remove your version of htop (remove the whole directories of htop)\033[0m\n"
			sleep 3
		fi
	elif [ "$is_installed" == "1" ]; then
		while true; do
			echo -en "\n\033[33mDo you want to install htop ? \033[0m"
			read -r htp
			case $htp in
				[Yy]* ) htp=1 && break;;
				[Nn]* ) htp=0 && break;;
				* ) echo -e "\nPlease answer yes or no !";;
			esac
		done
	else
		echo -e "\n\033[32m------- htop has been already installed -------\033[0m\n"
		sleep 2
		exit 2
	fi
	exit $htp
elif [[ $1 == "install" ]]; then
	echo -e "\n\033[33m------- Installing htop ... -------\033[0m\n"
	echo -e "\n\033[36m------- This will take several minutes -------\033[0m\n"
	if "$HOME"/goinfre/.brew/bin/brew install htop &>/dev/null; then
		echo -e "\n\033[32m------- htop has been installed successfully -------\033[0m\n"
	else
		echo -e "\n\033[32m------- htop has NOT been installed :( -------\033[0m\n"
	fi
fi
