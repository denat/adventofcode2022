#!/usr/bin/env bash

while read -r line; do
    len=${#line}
    left=${line:0:len/2}
	right=${line:len/2}
    item=$(comm -12 <(fold -w1 <<< "$left" | sort | uniq) <(fold -w1 <<< "$right" | sort | uniq))
    if [[ $item == [[:lower:]] ]]; then
        echo $(($(printf "%d" "'$item'") - 96))
    else
        echo $(($(printf "%d" "'$item'") - 38))
    fi
done < "input" | awk -v RS= '{$1=$1}1' | sed 's/ /+/g' | bc