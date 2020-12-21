#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou


machine="default"

if [[ $# != 2 ]];
  then
	echo "No enough arguments supplied"
	echo "Usage ==> dmcm [ name_of_the_virtual_machine ] [Option=> -c : to create/(remove & recreate) the machine | -r : to kill and restart the machine ]"
	exit 2
else
	machine="$1"
fi

docker stop "$(docker ps -aq &>/dev/null)" &>/dev/null

if docker-machine kill "$machine" &>/dev/null; then
	echo -e "\n$machine has been stopped\n"
fi

if [[ "$2" == "-c" ]]; then	
	if docker-machine rm "$machine" -y &>/dev/null; then
		echo -e "\n$machine has been removed\n"
	fi
	if docker-machine create --driver virtualbox "$machine" &>/dev/null; then
		echo -e "\n$machine has been created successfully !\n"
	fi
elif [[ "$2" == "-r" ]];then
	if docker-machine restart "$machine" &>/dev/null; then
		echo -e "\n$machine is running now\n"
	fi
fi

if docker-machine env "$machine" &>/dev/null; then
	echo -e "\033[32m\nrun this command [ eval \$(docker-machine env $machine) ]\n\033[0m"
else
	echo -e "\033[31m\nCould not complete your request :(\n\033[0m"
fi
