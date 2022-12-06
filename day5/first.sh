#!/usr/bin/env bash

input="input.txt"

push() { local -n stack=$1; shift; stack+=("$@"); }
peek() { local -n stack=$1; echo "${stack[-1]}"; }
pop() { peek "$1"; unset "$1[-1]"; }

nr_stacks=$(grep "^ 1" $input | tr -d ' ' | tail -c2)
nr_crates=$(grep "\[" $input | wc -l)

IFS=
for ((i=0; i<$nr_crates; i++)); do
    read -r line
    for ((j=0; j<$nr_stacks; j++)); do
        curr_stack="stack$j"
        curr_crate=$(cut -c $((2 + 4 * $j)) <<< $line)

        if [ $curr_crate = " " ]; then
            continue
        fi

        push $curr_stack $curr_crate
    done
done < <(tac $input | grep '\[')

IFS=' '
while read -r line; do
    read -r amt from to < <(cut -d' ' -f2,4,6 <<< $line)
    
    for ((i=0; i<$amt; i++)); do
        curr_crate=$(pop stack$((from-1)))
        pop stack$((from-1))
        push stack$((to-1)) $curr_crate
    done
done < <(grep '^move' $input)

for ((i=0; i<$nr_stacks; i++)); do
    echo $(peek stack$i)
done | tr -d '\n'; echo 
