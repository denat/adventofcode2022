#!/usr/bin/env bash

input="input.txt"

declare -A map
declare -A counted

i=0
j=0
rows=0
cols=0

# Build the map
while read -r line; do
    cols=${#line}
    for (( k=0; k<${#line}; k++ )); do
        map[$i,$k]=${line:$k:1}
    done
    i=$((i+1))
    rows=$((rows+1))
done < "$input"

max=0

check() {
    i_start=$1
    j_start=$2
    val=${map[$i_start,$j_start]}

    up=0    
    for (( i=i_start-1; i>=0; i-- )); do
        if [[ $i -lt 0 ]]; then
            break
        fi

        up=$((up+1))

        if [[ ${map[$i,$j_start]} -ge $val ]]; then
            break
        fi
    done

    down=0
    for (( i=i_start+1; i<rows; i++ )); do
        if [[ $i -ge rows ]]; then
            break
        fi

        down=$((down+1))

        if [[ ${map[$i,$j_start]} -ge $val ]]; then
            break
        fi
    done

    left=0
    for (( j=j_start-1; j>=0; j-- )); do
        if [[ $j -lt 0 ]]; then
            break
        fi

        left=$((left+1))

        if [[ ${map[$i_start,$j]} -ge $val ]]; then
            break
        fi
    done

    right=0
    for (( j=j_start+1; j<cols; j++ )); do
        if [[ $j -ge cols ]]; then
            break
        fi

        right=$((right+1))

        if [[ ${map[$i_start,$j]} -ge $val ]]; then
            break
        fi
    done

    total=$((up*down*left*right))

    if [[ $total -gt $max ]]; then
        echo "found new max: $total"
        max=$total
    fi
}

for (( k=0; k<rows; k++ )); do
    for (( m=0; m<cols; m++ )); do
        check $k $m
    done
done

echo "max: $max"