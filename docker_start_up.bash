#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou


machine="default"

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Please, give name of the machine you want to create as an argument !"
	exit 2
else
	machine="$1"
fi

docker stop "$(docker ps -aq &>/dev/null)" &>/dev/null

if docker-machine stop "$machine" &>/dev/null; then
	echo -e "\n$machine has been stopped\n"
fi

if docker-machine rm "$machine" -y &>/dev/null; then
	echo -e "\n$machine has been removed\n"
fi

if docker-machine create --driver virtualbox "$machine" &>/dev/null; then
	echo -e "\n$machine has been created successfully !\n"
fi

if docker-machine env &>/dev/null; then
	echo -e "\033[32m\nrun this command [ eval \$(docker-machine env) ]\n\033[0m"
else
	echo -e "\033[31m\nCould not complete your request :(\n\033[0m"
fi
