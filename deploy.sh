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

for file in ${FILES[@]}; do
	if [[ $(is_blacklisted $file) == "false" ]]; then
		echo "f: $file"
	fi
done

cp -r common build
cd build/common
mv .* ..
cd -
rm -rf build/common
echo $PWD

if [[ -n $(command -v uperm) ]]; then uperm -c -y -r; fi
