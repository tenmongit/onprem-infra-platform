#!/bin/bash

list_of_files="$1"
checked=0
missing=0

if [[ "$#" -eq 0 ]]; then
	echo "usage: ./scripts/check-paths.sh  <list-file>"
	exit 2
fi

if [[ ! -f "$list_of_files" ]]; then
	echo "list not found: $list_of_files"
	exit 2
fi

while IFS= read -r line; do
	if [[ -z "$line" || "$line" == \#* ]]; then
		continue
	fi

	checked=$((checked + 1))

	if [[ -f "$line" ]]; then
		echo "OK   file  $line"
	
	elif [[ -d "$line" ]]; then
		echo "OK   dir  $line"
	else
		echo "MISS       $line"
		missing=$((missing + 1))
	fi

	
done < "$list_of_files"


echo "checked: $checked, missing: $missing"

if [[ "$missing" -gt 0 ]]; then
	exit 1
else
	exit 0
fi
