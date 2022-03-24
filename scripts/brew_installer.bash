#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

ctrl_c() {
	pkill -f spin &>/dev/null
	echo -e "\b\033[31m KO ❌\033[0m"
	exit 1
}


printf "\n\033[33m------- brew ===> \033[0m"
sh -c './scripts/spin.bash 2>/dev/null &'
rm -rf brew* &>/dev/null
curl -L https://github.com/Homebrew/brew/archive/1.9.0.tar.gz >brew1.9.0.tar.gz 2>/dev/null
tar -xvzf brew1.9.0.tar.gz &>/dev/null
rm -rf brew1.9.0.tar.gz &>/dev/null
mv brew-1.9.0 .brew &>/dev/null
rm -rf ~/goinfre/.brew &>/dev/null
cp -Rf .brew ~/goinfre &>/dev/null
rm -rf ./.brew &>/dev/null


export PATH=$HOME/goinfre/.brew/bin:$PATH

# update and upgrade brew
brew update &>/dev/null
brew upgrade &>/dev/null

# downgrade brew to 3.2.17 which can install valgrind
cd ~/goinfre/.brew &>/dev/null && git fetch --tags &>/dev/null && git checkout -f 3.2.17 &>/dev/null && (cd - &>/dev/null || true)

# prevent brew from updating itself
export HOMEBREW_NO_AUTO_UPDATE=1

if ls ~/goinfre/.brew &>/dev/null; then
	pkill -f spin &>/dev/null
	echo -e "\b\033[32m OK ✅\033[0m"
else
	pkill -f spin &>/dev/null
	echo -e "\b\033[31m KO ❌\033[0m"
	exit 1
fi

exit 0
