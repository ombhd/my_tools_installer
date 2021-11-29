#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou

i=1
sp="/-\|"
echo -n ' '
while true; do
	echo -ne "\b${sp:i++%${#sp}:1}"
	sleep 0.1
done