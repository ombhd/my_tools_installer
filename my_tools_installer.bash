#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

#print a banner, and update all files
./scripts/banner.bash
git pull &>/dev/null

OLD_PATH=$PATH

# check storage first
if ! ./scripts/check_storage.bash; then
	exit 1
fi

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

ctrl_c() {
	echo -en "\b\b\b"
	pkill -f spin &>/dev/null
	stty echo
	exit 1
}

# declaring programs arrays, and another for their confirmations
progs=(valgrind node docker docker-machine minikube)
declare -a alreadyInstalledProgs
export PATH=$HOME/goinfre/.brew/bin:$PATH

# remove the already installed programs	from the progs array
# and add them to the alreadyInstalledProgs array
for i in "${!progs[@]}"; do
	if [[ -f "$HOME"/goinfre/.brew/bin/${progs[$i]} ]] || which "${progs[$i]}" &>/dev/null; then
		alreadyInstalledProgs+=("${progs[$i]}")
		unset "progs[$i]"
	fi
done

# print all the already installed progs elements with a loop
if [[ ${#alreadyInstalledProgs[@]} != "0" ]]; then
	printf "\nThe following programs are already installed:\n\n"
fi
for prog in "${alreadyInstalledProgs[@]}"; do
	sleep 0.3
	printf "\033[33m--- %s \033[0m ===> $(which "$prog")\n" "$prog"
done

echo

# if there is no progs to install, exit
if [[ "${#progs[@]}" == "0" ]]; then
	echo -e "\n\033[32m------- All programs are already installed -------\033[0m\n"
	sleep 1
	exit 0
fi

# confirm brew installation
sleep 0.3
echo -e "\n\033[33mDo you want to install: \033[0m"

# is something is selected
shouldInstall=0

declare -a progsToInstall

# get programs installation confirmations
for prog in "${progs[@]}"; do
	./scripts/is_confirmed.bash "$prog"
	# if at least one is selected, set shouldInstall to 1
	if [[ "$?" == "1" ]]; then
		shouldInstall=1
		progsToInstall+=("$prog")
	fi
done

# check if the confirmation array is empty
if [[ "$shouldInstall" == "0" ]]; then
	echo -e "\n\033[31m------- No program selected -------\033[0m\n"
	exit 0
fi

# show cursor and enable keyboard
cleanup() {
	tput cnorm
	stty echo
	pkill -f spin &>/dev/null
	/bin/rm -rf ~/.curlrc &>/dev/null
	/bin/rm -rf error.log &>/dev/null
	export PATH=$OLD_PATH
	SHELL_LANG=$(echo -n "$SHELL" | awk -F / '{print $3}')
	shell_f="${HOME}/.${SHELL_LANG}rc"
	brew &>/dev/null
	if [[ "$?" == "127" ]]; then
		echo -e "\n\033[32m ⛔️ Please, run this command: [ source $shell_f ]\033[0m\n"
		exit 1
	fi
	exit 0
}
# get back the cursor after exiting
trap cleanup EXIT

# hide cursor
tput civis
# disable keyboard
stty -echo

# start installing
echo -e "\n\033[33mInstalling programs...\033[0m"

# install brew if confirmed and update PATH
if [[ ! -f "$HOME"/goinfre/.brew/bin/brew ]]; then
	if ! ./scripts/brew_installer.bash; then
		exit 1
	fi
	./scripts/update_PATH.bash
fi

# install all confirmed installations
for prog in "${progsToInstall[@]}"; do
	./scripts/installer.bash "$prog"
done

if [[ " ${progsToInstall[*]} " =~ " docker " ]]; then
	./scripts/make_data_dir.bash docker
fi
if [[ " ${progsToInstall[*]} " =~ " minikube " ]]; then
	./scripts/make_data_dir.bash minikube
fi

if [[ " ${progsToInstall[*]} " =~ " docker " ]] || [[ " ${progsToInstall[*]} " =~ " docker-machine " ]]; then
	./scripts/dmcm_installer.bash
fi

exit 0
