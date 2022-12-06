#!/usr/bin/env bash

input="input.txt"

len=$(cat $input)

for ((i=0; i<${#len}; i++)); do
    substr=${len:$i:4}
    
    a=${substr:0:1}
    b=${substr:1:1}
    c=${substr:2:1}
    d=${substr:3:1}

    if [[ $a != $b && $a != $c && $a != $d && $b != $c && $b != $d && $c != $d ]]; then
        echo "FOUND! $((i+4))"
        break
    fi
done