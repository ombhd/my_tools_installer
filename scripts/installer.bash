#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

install_loader() {
	printf "\n\033[33m------- %s ===> \033[0m" "$1"
	sh -c './scripts/spin.bash 2>/dev/null &'
}

get_back_to_secure_mode() {
	/bin/rm -rf ~/.curlrc &>/dev/null
	export HOMEBREW_CURLRC=0
}


trap ctrl_c INT

ctrl_c() {
	pkill -f spin &>/dev/null
	echo -e "\b\033[31m KO ❌\033[0m"
	get_back_to_secure_mode
	exit 1
}

# remove the .curlrc file if it exists
cleanup() {
	get_back_to_secure_mode
	exit 0
}
# call cleanup when exiting
trap cleanup EXIT &>/dev/null

prog=$1
if [[ "$1" == "valgrind" ]]; then
	prog="--HEAD ./scripts/valgrind.rb"
fi

if [[ "$prog" == "node" ]]; then
	./scripts/nvm_installer.bash
	exit 0
else
	install_loader "$1"
fi

ERROR_LOG_FILE="error.log"

export PATH=$HOME/goinfre/.brew/bin:$PATH
export HOMEBREW_NO_AUTO_UPDATE=1

# if "$HOME"/goinfre/.brew/bin/brew install $prog &>/dev/null ; then
if "$HOME"/goinfre/.brew/bin/brew install $prog 2>$ERROR_LOG_FILE 1>/dev/null; then
	pkill -f spin &>/dev/null
	echo -e "\b\033[32m OK ✅\033[0m"
else
	pkill -f spin &>/dev/null
	echo -e "\b\033[31m KO ❌\033[0m"
	if grep "SSL certificate problem: certificate has expired" <$ERROR_LOG_FILE &>/dev/null; then
		pkill -f spin &>/dev/null
		echo -e "\b\n\033[31m SSL certificate problem detected\033[0m\n"
		echo " Retrying with insecure mode..."
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
	fi
fi

sleep 0.5
exit 0
