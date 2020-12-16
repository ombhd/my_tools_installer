#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

if [[ $1 == "question" ]]; then
	is_installed=$(which brew &>/dev/null; echo -n $?)
	path=$(which brew)
	if [[ "$is_installed" == "0" && "$path" != *"goinfre"* ]]; then
		while true; do
			echo -en "\n\033[33mbrew is not installed in goinfre\n\033[0m\n"
			echo -en "\n\033[33mDo you want to install it in goinfre ? \033[0m"
			read -r brw
			case $brw in
				[Yy]* ) brw=1 && break;;
				[Nn]* ) brw=0 && break;;
				* ) echo -e "\nPlease answer yes or no !";;
			esac
		done
		if [ "$brw" == "1" ]; then
			echo -en "\n\033[33mPlease, remove your version of brew (remove the whole directories [~/.brew] or [~/brew] ..!) \033[0m\n"
			sleep 3
		fi
	elif [[ "$is_installed" == "1" ]]; then
		while true; do
			echo -en "\n\033[33mDo you want to install brew ? \033[0m"
			read -r brw
			case $brw in
				[Yy]* ) brw=1 && break;;
				[Nn]* ) brw=0 && break;;
				* ) echo -e "\nPlease answer yes or no !";;
			esac
		done
	elif [[ "$is_installed" == "0" && "$path" == *"goinfre"* ]]; then
		echo -e "\n\033[32m------- brew has been already installed in goinfre -------\033[0m\n"
		sleep 2
		exit 2
	fi
	exit $brw
elif [[ $1 == "install" ]]; then
	echo -e "\n\033[33m------- Downloading brew ... -------\033[0m\n"
	rm -rf brew*       &>/dev/null
	curl -L https://github.com/Homebrew/brew/archive/1.9.0.tar.gz > brew1.9.0.tar.gz 2>/dev/null

	echo -e "\n\033[33m------- Installing brew ... -------\033[0m\n"
	tar -xvzf brew1.9.0.tar.gz	&>/dev/null
	rm -rf brew1.9.0.tar.gz	    &>/dev/null
	mv brew-1.9.0 .brew			&>/dev/null
	rm -rf ~/goinfre/.brew		&>/dev/null
	cp -Rf .brew ~/goinfre		&>/dev/null
	rm -rf ./.brew              &>/dev/null
	echo -e "\n\033[32m------- brew has been installed successfully -------\033[0m\n"
fi
