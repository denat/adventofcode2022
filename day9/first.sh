#!/usr/bin/env bash

input="input.txt"

head_i=0
head_j=0
tail_i=0
tail_j=0

are_adjacent() {
    local hi=$1
    local hj=$2
    local ti=$3
    local tj=$4

    if [[ $((ti-hi)) -gt 1 || $((ti-hi)) -lt -1 ]]; then
        echo 0
    elif [[ $((tj-hj)) -gt 1 || $((tj-hj)) -lt -1 ]]; then
        echo 0
    else
        echo 1
    fi
}

tail_next_move() {
    local hi=$1
    local hj=$2
    local ti=$3
    local tj=$4

    vdir=0
    if [[ $((ti-hi)) -ge 1 ]]; then
        vdir=-1
    elif [[ $((ti-hi)) -le -1 ]]; then
        vdir=1
    fi

    hdir=0
    if [[ $((tj-hj)) -ge 1 ]]; then
        hdir=-1
    elif [[ $((tj-hj)) -le -1 ]]; then
        hdir=1
    fi

    echo "$((ti+vdir)) $((tj+hdir))"
}

declare -A seen
seen[$tail_i,$tail_j]=1
unique_seen=1

while read -r line; do
    read direction nr_steps <<< "$line"
    for (( j=0; j<nr_steps; j++ )); do
        if [[ $direction = "R" ]]; then
            head_j=$((head_j+1))
        elif [[ $direction = "L" ]]; then
            head_j=$((head_j-1))
        elif [[ $direction = "U" ]]; then
            head_i=$((head_i-1))
        elif [[ $direction = "D" ]]; then
            head_i=$((head_i+1))
        fi

        if [[ $(are_adjacent $head_i $head_j $tail_i $tail_j) -eq 0 ]]; then
            read next_i next_j <<< $(tail_next_move $head_i $head_j $tail_i $tail_j)
            tail_i=$next_i
            tail_j=$next_j

            if [[ ${seen[$tail_i,$tail_j]} -ne 1 ]]; then
                seen[$tail_i,$tail_j]=1
                unique_seen=$((unique_seen+1))
            fi
        fi
    done
done < "$input"

echo "unique seen: $unique_seen"
