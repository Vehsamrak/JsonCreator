#!/bin/bash

# Welcome to JsonCreator for bash
# You can now easily format any data to json
#
# Autor:	Petr Karmashev
#		 	petr@quank.org
#
# Version:	1.0


case $1 in
'')
	echo -e "Usage:\033[1;33m jsoncreator.sh \033[0mkey value [another_key value_pairs] ... "
;;
*)
	# gather arguments to array
	declare -a pararray=($@)

	# counting arguments
	PARAMS=${#pararray[@]}
	
	# we want every key has it's value
	if ! [ $((PARAMS%2)) -eq 0 ];
	then
	    echo "Last key has no value. Please specify it."
	    exit
	fi

	# opening json
	echo -n "{"

	x=0
	EVEN=0
	# array processing
	while [ $x -lt $PARAMS ]; do
		if [[ $EVEN == 0 ]]; then
			# adding key to array of keys
			KEY=${pararray[$x]}

			EVEN=1
		else
			# adding value to array of values
			VALUE=${pararray[$x]}
			
			# separating by commas
			if [[ $x -lt $PARAMS-1 ]]; then
				COMMA=','
			else
				COMMA=''
			fi

			# formating key-value output
			printf '"%s":"%s"%s' $KEY $VALUE $COMMA

			EVEN=0
		fi
		
		x=$(( $x + 1 ))
	done

	# closing json
	echo "}"
;;
esac