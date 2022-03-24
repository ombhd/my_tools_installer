#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

install_loader() {
	printf "\n\033[33m------- %s ===> \033[0m" "$1"
	sh -c './scripts/spin.bash 2>/dev/null &'
}

install_loader "$1"

trap ctrl_c INT

ctrl_c() {
	pkill -f spin &>/dev/null
	echo -e "\b\033[31m KO ❌\033[0m"
	/bin/rm -rf ~/.curlrc &>/dev/null
	exit 1
}


# remove the .curlrc file if it exists
cleanup() {
	/bin/rm -rf ~/.curlrc &>/dev/null
	export HOMEBREW_CURLRC=0
	exit 0
}
# call cleanup when exiting
trap cleanup EXIT &>/dev/null

prog=$1
if [[ "$1" == "valgrind" ]]; then
	prog="--HEAD ./scripts/valgrind.rb"
fi

if [[ "$1" == "node" ]]; then
	prog="node@14"
fi

ERROR_LOG_FILE="error.log"

SHELL_LANG=$(echo -n "$SHELL" | awk -F / '{print $3}')
shell_f="${HOME}/.${SHELL_LANG}rc"

export PATH=$HOME/goinfre/.brew/bin:$PATH
export HOMEBREW_NO_AUTO_UPDATE=1

# if "$HOME"/goinfre/.brew/bin/brew install $prog &>/dev/null ; then
if "$HOME"/goinfre/.brew/bin/brew install $prog 2>$ERROR_LOG_FILE 1>/dev/null ; then
	pkill -f spin &>/dev/null
	echo -e "\b\033[32m OK ✅\033[0m"
else
	pkill -f spin &>/dev/null
	echo -e "\b\033[31m KO ❌\033[0m"
	if grep "SSL certificate problem: certificate has expired" <$ERROR_LOG_FILE; then
		pkill -f spin &>/dev/null
		echo -e "\b\n\033[31m SSL certificate problem detected\033[0m\n"
		echo "Going insecure mode..."
		echo insecure >~/.curlrc
		export HOMEBREW_CURLRC=1
		install_loader "$1"
		if "$HOME"/goinfre/.brew/bin/brew install $prog &>/dev/null; then
			pkill -f spin &>/dev/null
			echo -e "\b\033[32m OK ✅\033[0m"
		else
			pkill -f spin &>/dev/null
			echo -e "\b\033[31m KO ❌\033[0m"
			exit 1
		fi
	else
		echo
		echo "Here is a common way to solve this problem:"
		echo "1. run this command: [ rm -rf $HOME/goinfre/.brew ]"
		echo "2. run this command: [ source $shell_f ]"
		echo "3. run the script again"
		exit 1
	fi
fi

sleep 0.5
exit 0