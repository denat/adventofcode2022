#!/usr/bin/env bash

# read the input file in lines of 3 
while read -r line1; read -r line2; read -r line3; do
    possibly_badge=$(comm -12 <(fold -w1 <<< "$line1" | sort | uniq) <(fold -w1 <<< "$line2" | sort | uniq))
    badge=$(comm -12 <(fold -w1 <<< "$possibly_badge" | sort | uniq) <(fold -w1 <<< "$line3" | sort | uniq))
    if [[ $badge == [[:lower:]] ]]; then
        echo $(($(printf "%d" "'$badge'") - 96))
    else
        echo $(($(printf "%d" "'$badge'") - 38))
    fi
done < "input" | awk -v RS= '{$1=$1}1' | sed 's/ /+/g' | bc    