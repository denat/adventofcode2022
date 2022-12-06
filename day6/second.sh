#!/usr/bin/env bash

input="input.txt"

len=$(cat $input)

declare -A map

size=14
count=0
left_bound=0
for ((i=0; i<${#len}; i++)); do
    curr=${len:$i:1}
    count=$((count+1))

    if [[ ${map[$curr]} ]]; then
        if [[ ${map[$curr]} -ge $((i-size-1)) && ${map[$curr]} -ge $left_bound ]]; then
            count=$((count-${map[$curr]}-1+$left_bound))
            left_bound=$((${map[$curr]}+1))
        fi
    fi
    
    if [[ $count -eq $size ]]; then
        echo "FOUND! $((i+1))"
        break
    fi

    map[$curr]=$i
done