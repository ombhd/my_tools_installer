#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

#print a banner, and update all files
./scripts/banner.bash
git pull &>/dev/null

# check storage first
if ! ./scripts/check_storage.bash; then
	exit 1
fi

# declaring programs arrays, and another for their confirmations
progs=(valgrind node docker docker-machine minikube)
declare -a confs

# confirm brew installation
echo -e "\n\033[33mDo you want to install \033[0m"
./scripts/is_confirmed.bash brew
# exit if confirmation was negative, because other programs installation depends on brew
brw=$?
if [[ "$brw" == "0" ]]; then
	exit 0
fi

# get programs installation confirmations
for prog in "${progs[@]}"; do
	./scripts/is_confirmed.bash "$prog"
	confs+=($?)
done

# check if the confirmation array is empty
if [[ "${#confs[@]}" == "0" ]]; then
	echo -e "\n\033[31mNo programs were selected to install.\033[0m"
	exit 1
fi

# show cursor
cleanup() {
	tput cnorm
}
# get back the cursor after exiting
trap cleanup EXIT

# hide cursor
tput civis

# start installing
echo -e "\n\033[33mInstalling programs...\033[0m"

# install brew if confirmed and update PATH
if [[ "$brw" == "1" ]]; then
	if ! ./scripts/brew_installer.bash; then
		exit 1
	fi
	./scripts/update_PATH.bash
fi

# install all confirmed installations
i=0
for conf in "${confs[@]}"; do
	if [[ "$conf" == "1" ]]; then
		./scripts/installer.bash "${progs[$i]}"
	fi
	((i++))
done

./scripts/make_data_dir.bash "${confs[2]}" docker
./scripts/make_data_dir.bash "${confs[4]}" minikube

if [[ "${confs[2]}" == "0" ]]; then
	exit 0
else
	./scripts/dmcm_installer.bash
fi

exit 0
