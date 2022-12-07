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

free_space=$((70000000-${dirs["/"]}))
needed_space=$((30000000-$free_space))
echo "free space: $free_space"
echo "needed space: $needed_space"

sorted_dirs=($(for i in "${!dirs[@]}"; do echo "${dirs[$i]} $i"; done | sort -n | cut -d' ' -f2 | tac))

to_delete="/"
for i in "${sorted_dirs[@]}"; do
    if [[ ${dirs[$i]} -gt $needed_space ]]; then
        to_delete=$i
    fi
done

echo $to_delete
echo ${dirs[$to_delete]}
