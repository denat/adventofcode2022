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

total_visible_trees=0

for (( i=1; i<rows-1; i++ )); do
    max=-1
    for (( j=0; j<cols; j++ )); do
        if [[ ${map[$i,$j]} -gt $max ]]; then
            max=${map[$i,$j]}

            if [[ ${counted[$i,$j]} -ne 1 ]]; then
                counted[$i,$j]=1
                total_visible_trees=$((total_visible_trees+1))
            fi
        fi
    done
done

for (( i=1; i<rows-1; i++ )); do
    max=-1
    for (( j=cols-1; j>=0; j-- )); do
        if [[ ${map[$i,$j]} -gt $max ]]; then
            max=${map[$i,$j]}

            if [[ ${counted[$i,$j]} -ne 1 ]]; then
                counted[$i,$j]=1
                total_visible_trees=$((total_visible_trees+1))
            fi
        fi
    done
done

for (( j=1; j<cols-1; j++ )); do
    max=-1
    for (( i=0; i<rows; i++ )); do
        if [[ ${map[$i,$j]} -gt $max ]]; then
            max=${map[$i,$j]}

            if [[ ${counted[$i,$j]} -ne 1 ]]; then
                counted[$i,$j]=1
                total_visible_trees=$((total_visible_trees+1))
            fi
        fi
    done
done

for (( j=1; j<cols-1; j++ )); do
    max=-1
    for (( i=rows-1; i>=0; i-- )); do
        if [[ ${map[$i,$j]} -gt $max ]]; then
            max=${map[$i,$j]}

            if [[ ${counted[$i,$j]} -ne 1 ]]; then
                counted[$i,$j]=1
                total_visible_trees=$((total_visible_trees+1))
            fi
        fi
    done
done

echo "total_visible_trees: $(($total_visible_trees+4))"
