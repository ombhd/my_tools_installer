#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

echo -e "\n\033[33m------- Downloading brew ... -------\033[0m\n"
rm -rf brew*   &>/dev/null
curl -L https://github.com/Homebrew/brew/archive/1.9.0.tar.gz > brew1.9.0.tar.gz 2>/dev/null

echo -e "\n\033[33m------- Installing brew ... -------\033[0m\n"
tar -xvzf brew1.9.0.tar.gz	&>/dev/null
rm -rf brew1.9.0.tar.gz	    &>/dev/null
mv brew-1.9.0 .brew			&>/dev/null
rm -rf ~/goinfre/.brew		&>/dev/null
cp -Rf .brew ~/goinfre		&>/dev/null
rm -rf ./.brew              &>/dev/null

# update and upgrade brew
brew update &>/dev/null
brew upgrade &>/dev/null

# downgrade brew to 3.2.17 which can install valgrind
cd ~/goinfre/.brew &>/dev/null && git fetch --tags &>/dev/null && git checkout -f 3.2.17 &>/dev/null && (cd - &>/dev/null || true)

# prevent brew from updating itself
export HOMEBREW_NO_AUTO_UPDATE=1

if ls ~/goinfre/.brew &>/dev/null ; then 
	echo -e "\n\033[32m------- brew has been installed successfully -------\033[0m\n"
else
	echo -e "\n\033[31m------- brew has NOT been installed :( -------\033[0m\n"
	exit 1
fi

exit 0
