#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou


# make soft link
rm -rf "$HOME"/."$2" &>/dev/null
ln -s "$HOME"/goinfre/."$2" "$HOME"/."$2" &>/dev/null

# exit if the command already installed and its data_dir exists in goinfre 
if [[ "$1" == "2" && -d "$HOME"/goinfre/."$2" ]]; then
	exit 0
fi
if [[ "$1" == "1" || "$1" == "2" ]]; then
	rm -rf "$HOME"/goinfre/."$2" &>/dev/null
	mkdir "$HOME"/goinfre/."$2" &>/dev/null
fi

exit 0
