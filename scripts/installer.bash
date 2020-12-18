#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

echo -e "\n\033[33m------- Installing $1 ... -------\033[0m\n"
echo -e "\n\033[36m------- This will take some time -------\033[0m\n"

prog=$1
if [[ "$1" == "valgrind" ]]; then
	prog="--HEAD ./scripts/valgrind.rb"
fi

if "$HOME"/goinfre/.brew/bin/brew install $prog &>/dev/null ; then
	echo -e "\n\033[32m------- $1 has been installed successfully -------\033[0m\n"
else
	echo -e "\n\033[31m------- $1 has NOT been installed :( -------\033[0m\n"
fi

sleep 1