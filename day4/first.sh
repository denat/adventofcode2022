#!/usr/bin/env bash

while read -r line; do
    awk -F, '{print $1, $2}' <<< "$line" | awk -F- '{print $1, $2, $3, $4}' |
        while read -r f1 f2 s1 s2; do 
            if [[ $f1 -le $s1 && $f2 -ge $s2 ]]; then
                echo 1
            elif [[ $f1 -ge $s1 && $f2 -le $s2 ]]; then
                echo 1
            else
                echo 0
            fi
        done
done < "input" | awk -v RS= '{$1=$1}1' | sed 's/ /+/g' | bc