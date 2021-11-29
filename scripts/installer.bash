#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou


printf "\n\033[33m------- %s ===> \033[0m" "$1"
sh -c './scripts/spin.bash 2>/dev/null &'

prog=$1
if [[ "$1" == "valgrind" ]]; then
	prog="--HEAD ./scripts/valgrind.rb"
fi

if [[ "$1" == "node" ]]; then
	prog="node@14"
fi

if "$HOME"/goinfre/.brew/bin/brew install $prog &>/dev/null ; then
	pkill -f spin &>/dev/null
	echo -e "\b\033[32m OK ✅\033[0m"
else
	pkill -f spin &>/dev/null
	echo -e "\b\033[31m KO ❌\033[0m"
fi

sleep 1
