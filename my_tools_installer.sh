#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

echo -e "\n\033[33m------- Downloading brew ... -------\033[0m\n"
curl -L https://github.com/Homebrew/brew/archive/1.9.0.tar.gz > brew1.9.0.tar.gz 

echo -e "\n\033[33m------- Installing brew ... -------\033[0m\n"
tar -xvzf brew1.9.0.tar.gz	
rm -rf brew1.9.0.tar.gz	
mv brew-1.9.0 .brew			
rm -rf ~/goinfre/.brew		
cp -Rf .brew ~/goinfre		
rm -rf ./.brew
echo -e "\n\033[32m------- brew has been installed successfully -------\033[0m\n"

echo -e "\n\033[33m------- Downloading valgrind ... -------\033[0m\n"
brew install --HEAD ./valgrind.rb 
echo -e "\n\033[32m------- valgrind has been installed successfully -------\033[0m\n"

echo -e "\n\033[33m------- Installing htop ... -------\033[0m\n"
brew install htop 
echo -e "\n\033[33m------- htop has been installed successfully -------\033[0m\n"

