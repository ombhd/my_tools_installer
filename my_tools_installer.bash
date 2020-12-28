#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

#
./scripts/banner.bash
git pull &>/dev/null

# declaring programs arrays, and another for their confirmations
progs=(valgrind htop docker docker-machine minikube)
declare -a confs

# confirm brew installation
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

# install brew if confirmed and update PATH
if [[ "$brw" == "1" ]]; then
	if ! ./scripts/brew_installer.bash ; then 
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
