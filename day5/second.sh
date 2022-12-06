#!/usr/bin/env bash

input="input.txt"

push() { local -n stack=$1; shift; stack+=("$@"); }
peek() { local -n stack=$1; echo "${stack[@]: -${2:-1}}"; }
pop() { peek "$1" "$2"; for ((i=0; i<$2; i++)); do unset "$1[-1]"; done; }

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
    crates=$(pop stack$((from-1)) $amt)
    pop stack$((from-1)) $amt
    push stack$((to-1)) $crates
done < <(grep '^move' $input)

for ((i=0; i<$nr_stacks; i++)); do
    echo $(peek stack$i)
done | tr -d '\n'; echo 
