#!/bin/bash

user="$1"


if [ $# -ne 1 ]
then
	echo "1개의 인수만 입력하세요."
	exit 1
fi

login=$(cut -f1 who)

for var in login
do
if [ $var = $user ]
then
	echo "$user는 로그인함!"
	break
else	
	sleep 60
fi
done

