#!/usr/bin/env bash

function usage(){
	echo -e "error: $1\n\nusage: ./deploy.sh <shell type>\n\tShells:\n\t\t* bash\n\t\t* zsh"
	exit -1
}

function is_meta(){
	file=$(echo $1 | rev | cut -d/ -f1 | rev)
	if [[ "$file" == "." ]] || [[ "$file" == ".." ]]; then
		echo "true"
	else
		echo "false"
	fi
}

function add_dir(){
	for file in $(echo "$1/.*"); do
		if [[ $(is_meta $file) == "false" ]]; then
			cp -r $file $INSTALL_PATH
		fi
	done
}

if [[ -n $1 ]]; then
	MODE=$1
else
	MODE=$(echo $SHELL | rev | cut -d/ -f1 | rev)
fi

if [[ -n $1 ]]; then
	INSTALL_PATH=$2
else
	INSTALL_PATH=$HOME
fi

echo -e "Using shell: $MODE\nInstalling to path: $INSTALL_PATH"

if [[ -z $MODE ]]; then
	usage "not enough arguments!"
elif [[ $MODE == "bash"  ]]; then
	add_dir bash
elif [[ $MODE == "zsh"  ]]; then
	add_dir zsh
else
	usage "invalid shell!"
fi

add_dir common

if [[ -n $(command -v uperm) ]]; then uperm -c -y -r > /dev/null 2>&1; fi
