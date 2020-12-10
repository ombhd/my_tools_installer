#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

echo -e "\n\033[33m------- Downloading brew ... -------\033[0m\n"
curl -L https://github.com/Homebrew/brew/archive/1.9.0.tar.gz > brew1.9.0.tar.gz #&>/dev/null

echo -e "\n\033[33m------- Installing brew ... -------\033[0m\n"
tar -xvzf brew1.9.0.tar.gz	#&>/dev/null
rm -rf brew1.9.0.tar.gz		#&>/dev/null
mv brew-1.9.0 .brew			#&>/dev/null
rm -rf ~/goinfre/.brew		#&>/dev/null
cp -Rf .brew ~/goinfre		#&>/dev/null
echo -e "\n\033[32m------- brew has been installed successfully -------\033[0m\n"

echo -e "\n\033[33m------- Downloading valgrind ... -------\033[0m\n"
brew install --HEAD ./valgrind.rb #&>/dev/null
echo -e "\n\033[32m------- valgrind has been installed successfully -------\033[0m\n"

echo -e "\n\033[33m------- Installing htop ... -------\033[0m\n"
brew install htop #&>/dev/null
echo -e "\n\033[33m------- htop has been installed successfully -------\033[0m\n"

