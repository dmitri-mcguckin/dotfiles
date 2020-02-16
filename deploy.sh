#!/usr/bin/env bash

function usage(){
	echo -e "error: $1\n\nusage: ./deploy.sh <shell type>\n\tShells:\n\t\t* bash\n\t\t* zsh"
	clean
	exit -1
}

function clean(){
	rm -rf build
}

MODE=$1
INSTALL_PATH=$HOME
clean

if [[ -z $MODE ]]; then
	usage "not enough arguments!"
fi

if [[ $MODE == "bash"  ]]; then
	cp -r bash build
elif [[ $MODE == "zsh"  ]]; then
	cp -r zsh build
else
	usage "invalid shell!"
fi

cp -r common build
cd build/common
mv .* .. > /dev/null 2>&1
cd ../..
rm -rf build/common
echo "Installing dot files to: $INSTALL_PATH"
mv build/.* $INSTALL_PATH > /dev/null  2>&1

if [[ -n $(command -v uperm) ]]; then uperm -c -y -r > /dev/null 2>&1; fi
