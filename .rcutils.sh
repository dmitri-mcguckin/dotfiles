#!/bin/bash

function say(){
    if   [[ $1 == 0 ]]; then MODE="INFO"
    elif [[ $1 == 1 ]]; then MODE="WARN"
    elif [[ $1 == 2 ]]; then MODE="ERROR"
    elif [[ $1 == 3 ]]; then MODE="DEBUG";
    else
        say 2 "Expected mode [0-3], got: $1"
        return 1
    fi

	echo -e "[$MODE]: $2"
    return 0
}

function load_file(){
	if [ -f $1 ]; then
		source $1
	else
		say 1 "Skipping file: $1\n\tDoes not exist!"
	fi
    return 0
}

function iface(){
    BLACKLIST=( lo tun0 vcan0 )
    INT=$(ip a | grep state | cut -d ':' -f2 | xargs)
    IFACE=$(echo $INT | cut -d ' ' -f 2)
    echo $IFACE
    return 0
}

function lab(){
	if [[ -z $1 ]]; then
		FILE=Example
	else
		FILE=$(echo $1 | cut -d. -f1 | xargs)
	fi

	if [[ -f $FILE.java ]]; then
		javac $FILE.java
		java $FILE
	else
		echo -e "File not found: $FILE.java"
	fi
}

function loop(){
	BASE=$1
	ARGS=${@:2}
	ARGS="$(echo $ARGS | xargs)"

	while [ 1 ]; do
		clear
		echo "$(date)"
		echo $OUTPUT
		OUTPUT=$($BASE $ARGS)
		sleep 1

	done
}
