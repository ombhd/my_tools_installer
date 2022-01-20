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

if docker-machine kill "$machine" &>/dev/null; then
	echo -e "\n$machine has been stopped\n"
fi

if docker-machine rm "$machine" -y &>/dev/null; then
	echo -e "\n$machine has been removed\n"
fi

if ! ls "$HOME"/.docker/machine/cache/boot2docker.iso &>/dev/null; then
curl -Lo "$HOME"/.docker/machine/cache/boot2docker.iso https://github.com/boot2docker/boot2docker/releases/download/v18.09.1-rc1/boot2docker.iso &>/dev/null
fi

if docker-machine create --driver virtualbox "$machine" &>/dev/null; then
	echo -e "\n$machine has been created successfully !\n"
fi

if docker-machine env "$machine" &>/dev/null; then
	echo -e "\033[32m\nrun this command [ eval \$(docker-machine env $machine) ]\n\033[0m"
else
	echo -e "\033[31m\nCould not complete your request :(\n\033[0m"
	exit 1
fi

exit 0
