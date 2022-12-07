#!/usr/bin/env bash

input="input.txt"

declare -A dirs
declare -A files_traversed
dirs["/"]=0
currdir="/"

while read -r line; do
    if [[ $line = \$* ]]; then
        cmd=$(echo $line | cut -d' ' -f2)

        if [[ $cmd == "cd" ]]; then
            dir=$(echo $line | cut -d' ' -f3)

            if [[ $dir = ".." ]]; then
                currdir=$(echo $currdir | rev | cut -d'/' -f3- | rev)/
            elif [[ $dir = "/" ]]; then
                currdir="/"
            else
                currdir=$currdir$dir/
            fi

            if [[ -z ${dirs[$currdir]} ]]; then
                dirs[$currdir]=0
            fi
            echo "current dir: $currdir"
        fi
    else 
        firstpart=$(echo $line | cut -d' ' -f1)

        if [[ $firstpart == "dir" ]]; then
            dir=$(echo $line | cut -d' ' -f2)
        else
            file=$(echo $line | cut -d' ' -f2)
            if [[ -z ${files_traversed[$currdir$file]} ]]; then
                files_traversed[$file]=1
                dirs[$currdir]=$((${dirs[$currdir]}+$firstpart))
                currdir2=$currdir
                while [[ $currdir2 != "/" ]]; do
                    currdir2=$(echo $currdir2 | rev | cut -d'/' -f3- | rev)/
                    dirs[$currdir2]=$((${dirs[$currdir2]}+$firstpart))
                done
            fi
        fi
    fi
done < "$input"

for i in "${!dirs[@]}"; do
    if [[ ${dirs[$i]} -le 100000 ]]; then
        echo "${dirs[$i]}"
    fi
done | awk -v RS= '{$1=$1}1' | sed 's/ /+/g' | bc