#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

rm -rf "$HOME"/docker_start_up.bash &>/dev/null
cp -f docker_start_up.bash "$HOME" &>/dev/null

shell_f=$(echo -n "$SHELL" | awk -F / '{print $3}')
shell_f="${HOME}/.${shell_f}rc"

line=$(grep -E "alias dmcm='bash ~/docker_start_up.bash'" < "$shell_f")

if [[ "$line" == *"alias dmcm='bash ~/docker_start_up.bash'"* ]]; then
	exit 0
fi

if echo "alias dmcm='bash ~/docker_start_up.bash'" >> "$shell_f";
then
	echo -e "\n\033[32m -- dmcm command has been successfully installed! Enjoy :) --\n\n\033[0m"
	echo -e "\033[36m ===> Please, run this command now : [\033[33m source $shell_f\033[0m\033[36m ] --\n\n\033[0m" 
	echo -e "\033[36m -- You can use dmcm command this way: [\033[33m dmcm name_of_machine \033[0m\033[36m]--\n\033[0m" 
	echo -e "\033[36m -- dmcm command is just an alias to:\n" 
	echo -e " ◊ Some cleaning commands, related to docker-machine and docker!\n" 
	echo -e " ◊ [\033[33m docker-machine create --driver virtualbox name_of_machine \033[0m\033[36m]\n\033[0m" 
	echo -e "\033[36m -- It creates a virtual machine with the name you submit for docker --\n\033[0m" 
else
	echo -e "\033[31m\n -- dmcm command has NOT been installed ! :( --\n\033[0m"
	exit 1
fi
exit 0
