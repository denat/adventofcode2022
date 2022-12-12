#!/usr/bin/env bash

input="input.txt"
set -o noglob # Need this to prevent the wildcard (*) from being expanded
rounds=20

# Build the monkeys
declare -A monkeys # value is of the format "operation|test|throw_if_true|throw_if_false"
declare -A monkey_items
declare -A monkey_inspects

# Parse the monkeys
curr_monkey=
while read -r line; do
    if [[ "$line" =~ ^Monkey\ ([0-9]+)\:$ ]]; then
        curr_monkey=${BASH_REMATCH[1]}
    elif [[ "$line" == *Starting*  ]]; then
        monkey_items[$curr_monkey]=$(tr -d ',' <<< "${line#Starting items: }")
    elif [[ "$line" == *Operation* ]]; then
        monkeys[$curr_monkey]="${line#Operation: new = }"
    elif [[ "$line" == *Test* ]]; then
        monkeys[$curr_monkey]+="|${line#Test: divisible by }"
    elif [[ "$line" == *If\ true* ]]; then
        monkeys[$curr_monkey]+="|${line#If true: throw to monkey }"
    elif [[ "$line" == *If\ false* ]]; then
        monkeys[$curr_monkey]+="|${line#If false: throw to monkey }"
    fi
done < "$input"

# Run the monkeys
for ((i=0; i<$rounds; i++)); do
    for ((j=0; j<${#monkeys[@]}; j++)) do
        for item in ${monkey_items[$j]}; do
            if [[ -z $monkey_inspects[$j] ]]; then
                monkey_inspects[$j]=0
            fi
            monkey_inspects[$j]=$((monkey_inspects[$j]+1))
            new_worry_level=$(($(cut -d'|' -f1 <<< "${monkeys[$j]}" | sed "s/old/$item/g")))
            chill_level=$((new_worry_level/3))
            divisible_by=$(cut -d'|' -f2 <<< "${monkeys[$j]}")

            if (( $chill_level % $divisible_by == 0 )); then
                throw_to=$(cut -d'|' -f3 <<< "${monkeys[$j]}")
            else
                throw_to=$(cut -d'|' -f4 <<< "${monkeys[$j]}")
            fi

            monkey_items[$throw_to]+=" $chill_level"
            monkey_items[$j]=$(tr ' ' '\n' <<< $item | tail -n+2 | tr '\n' ' ' | xargs)
        done
    done
done

for ((i=0; i<${#monkey_inspects[@]}; i++)); do echo ${monkey_inspects[$i]}; done | sort -n | tail -n2 | awk -v RS= '{$1=$1}1' | sed 's/ /*/g' | bc

