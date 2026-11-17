#!/usr/bin/bash

if [ $# -ne 1 ]
then
	echo "ce programme demande un argument"
		exit 1
fi

URLS=$1
num=1
while read -r line;
do
	echo -n -e "$num\t$line"
	if [[ $line =~ ^https?:// ]]
	then
        HTTP=$(curl -s -L -o /dev/null -w "%{http_code}" "$line")
        encodage=$(curl -s -I "$line" | grep -o -i "charset=[^ ;]*" | tr -d '\r')
        nombre_mot=$(curl -s "$line" | wc -w)
		echo -e "\t$HTTP\t$encodage\t$nombre_mot"
	else
		echo -e "\tne ressemble pas à une URL valide"
	fi
	num=$(expr $num + 1)
done < "$URLS"
