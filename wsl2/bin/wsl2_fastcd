#!/usr/bin/bash

tmp="/tmp/wsl2_fastcd_$USER.tmp"

if [[ $1 == "" ]]; then
	echo $PWD > $tmp
	cat $tmp
elif [[ $1 == "clear" ]]; then
	rm -rf $tmp
elif [[ $1 == "login" ]]; then
	if [ -f "$tmp" ]; then
		cat $tmp
		cd $(cat $tmp)
		exec $(awk -F: -v user="$2" '$1 == user {print $NF}' /etc/passwd) 
	else
		echo "no dir"
		exit 0
	fi
else
    echo "$1" > $tmp
fi

exit 0
