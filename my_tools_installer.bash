#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

./scripts/brew_installer.bash question
brw=$?

./scripts/valgrind/valgrind_installer.bash question
valg=$?

./scripts/htop_installer.bash question
htp=$?

if [[ "$brw" == "1" ]]; then
	./scripts/brew_installer.bash install
	./scripts/update_PATH.bash
fi

if [[ "$valg" == "1" ]]; then
	./scripts/valgrind/valgrind_installer.bash install
fi

if [[ "$htp" == "1" ]]; then
	./scripts/htop_installer.bash install
fi
