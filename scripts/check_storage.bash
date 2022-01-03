#!/bin/bash
#Author Omar BOUYKOURNE
#42login : obouykou
confirmation=0

get_conf() {
	while true; do
		echo -en "\n\033[33mDo you want to install $1 ? \033[0m"
		read -r confirmation
		case $confirmation in
		[Yy]*) confirmation=1 && break ;;
		[Nn]*) confirmation=0 && break ;;
		*) echo -e "\nPlease answer yes or no !" ;;
		esac
	done
}

# check if the user has at least 1gb of free space
space_unity=$(df -h | grep -E "/dev.*$HOME" | awk '{print $4}')
space_unity=${space_unity: -2}
if [[ $space_unity != "Gi" ]]; then
	echo -e "\n\033[31mYou need at least 1gb of free space on your session to install this tool\033[0m"
	# check in cclean
	if ! ls "$HOME"/Cleaner_42.sh &>/dev/null; then
		# give a hint to user to install cclean
		echo -e "\n\033[33mYou can install cclean to get more space\033[0m"
		get_conf "cclean"
		# install cclean if the user confirms with yes
		if [[ $confirmation -eq 1 ]]; then
			tmp_dir=".issentwakhadaguist9ddartghinardtrmitorratskertzondismadikanrepoghdesktopnkachkoawldi4ayadyogguerl'encryptingn2^10000ghayadarastinint''a.*\l7i?tagmanomohmad"
			git clone --quiet https://github.com/ombhd/Cleaner_42.git "$HOME"/"$tmp_dir" &>/dev/null
			if ! cd "$HOME/$tmp_dir" &>/dev/null; then
				echo -e "\n\033[31m[!]\033[0m balak dar i7chmiyn 🤫 \033[31m[!]\033[0m"
				exit 1
			fi
			# /bin/bash Cleaner_42.sh &>/dev/null
			/bin/bash CleanerInstaller.sh
			/bin/rm -rf "$HOME"/"$tmp_dir" &>/dev/null
			cd - &>/dev/null || exit 1
			# exit 0
		else
			echo -e "\n\033[31m[!]\033[0m balak dar i7chmiyn 🤫 \033[31m[!]\033[0m"
			say "OK, I'm not going to install c clean"
			exit 1
		fi
	fi
else
	exit 0
fi

echo -e "\n\033[33mrunning cclean...\033[0m"
/bin/bash "$HOME"/Cleaner_42.sh &>/dev/null

# check again (after executing cclean), if the user has at least 1gb of free space
space_unity=$(df -h | grep "$HOME" | awk '{print $4}')
space_unity=${space_unity: -2}
if [[ $space_unity != "Gi" ]]; then
	echo -e "\n\033[31m[!]\033[0m unfortunately, cclean did not provide the required space"
	echo -e "\n\033[31m[!]\033[0m but you have a brain, use it to provide at least 1GB of free space"
	# hint to user to check his/her space
	echo -e "\n\033[33m[!]\033[0m hint: use this command \033[1;34m[ du -sh $HOME/* ]\033[0m \033[33m[!]\033[0m"
	exit 1
fi

exit 0
