#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

SHELL_LANG=$(echo -n "$SHELL" | awk -F / '{print $3}')
shell_f="${HOME}/.${SHELL_LANG}rc"

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

install_loader() {
	printf "\n\033[33m------- %s ===> \033[0m" "$1"
	sh -c './scripts/spin.bash 2>/dev/null &'
}

install_loader "nvm"

ERROR_LOG_FILE="error.log"

export PATH=$HOME/goinfre/.brew/bin:$PATH
export HOMEBREW_NO_AUTO_UPDATE=1

# install nvm with brew
if "$HOME"/goinfre/.brew/bin/brew install nvm 2>$ERROR_LOG_FILE 1>/dev/null; then
	pkill -f spin &>/dev/null
	echo -e "\b\033[32m OK ✅\033[0m"
else
	pkill -f spin &>/dev/null
	echo -e "\b\033[31m KO ❌\033[0m"
	if grep "SSL certificate problem: certificate has expired" <$ERROR_LOG_FILE &>/dev/null; then
		pkill -f spin &>/dev/null
		echo -e "\b\n\033[31m SSL certificate problem detected\033[0m\n"
		echo " Going insecure mode..."
		echo insecure >~/.curlrc
		export HOMEBREW_CURLRC=1
		install_loader "$1"
		if "$HOME"/goinfre/.brew/bin/brew install nvm &>/dev/null; then
			pkill -f spin &>/dev/null
			echo " Going back to secure mode..."
			echo -e "\b\033[32m OK ✅\033[0m"
		else
			pkill -f spin &>/dev/null
			echo -e "\b\033[31m KO ❌\033[0m"
			echo " Going back to secure mode..."
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


# make the home directory for the nvm installer, and symlink it to the user's home directory
mkdir  "$HOME"/goinfre/.nvm &>/dev/null
/bin/rm -rf "$HOME"/.nvm &>/dev/null
ln -s "$HOME"/goinfre/.nvm "$HOME"/.nvm &>/dev/null

# add the nvm config the shell config file
echo >> "$shell_f"
echo "# nvm configuration" >>"$shell_f"
echo 'export NVM_DIR=$HOME/.nvm' >> "$shell_f"
echo '[ -s "$HOME/goinfre/.brew/opt/nvm/nvm.sh" ] && \. "$HOME/goinfre/.brew/opt/nvm/nvm.sh"  # This loads nvm' >> "$shell_f"
echo '[ -s "$HOME/goinfre/.brew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOME/goinfre/.brew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion' >> "$shell_f"
# install node 16
install_loader "node 16"

export NVM_DIR=$HOME/.nvm
[ -s "$HOME/goinfre/.brew/opt/nvm/nvm.sh" ] && \. "$HOME/goinfre/.brew/opt/nvm/nvm.sh"
[ -s "$HOME/goinfre/.brew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOME/goinfre/.brew/opt/nvm/etc/bash_completion.d/nvm"
if nvm install 16 2>$ERROR_LOG_FILE 1>/dev/null; then
	pkill -f spin &>/dev/null
	echo -e "\b\033[32m OK ✅\033[0m"
else
	pkill -f spin &>/dev/null
	echo -e "\b\033[31m KO ❌\033[0m"
fi


# tell the user to source the shell config file
echo -e "\n\033[32m ⛔️ Please, run this command: [ source $shell_f ]\033[0m\n"
echo -e "\n\033[33m You can install any node version you want with [ nvm install version_number ]  \033[0m"
echo -e "\n\033[33m ex: nvm install 17 \033[0m"