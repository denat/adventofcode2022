#!/usr/bin/env bash

input="input.txt"

declare -A commands
i=0

while read -r line; do
    commands[$i]=$line
    ((i++))
done < "$input"

curr_command=
x_reg=1
total_cycles=0
pointer=0
cycle_counter=0
result=0
while true; do 
    total_cycles=$((total_cycles+1))

    if [[ -z $curr_command ]]; then
        read curr_command amount <<< ${commands[$pointer]}

        if [[ -z $curr_command ]]; then
            break
        fi
    fi

    if [[ $total_cycles -eq 20 
                    || $total_cycles -eq 60 
                    || $total_cycles -eq 100
                    || $total_cycles -eq 140 
                    || $total_cycles -eq 180 
                    || $total_cycles -eq 220 ]]; then
                val=$((x_reg*total_cycles))
                result=$((result+val))
            fi

    if [[ $curr_command == "addx" ]]; then
        if [[ $cycle_counter -eq 1 ]]; then
            x_reg=$((x_reg+amount))
            curr_command=
            cycle_counter=0
            pointer=$((pointer+1))
        else
            cycle_counter=$((cycle_counter+1))
        fi
    elif [[ $curr_command == "noop" ]]; then
        cycle_counter=0
        curr_command=
        pointer=$((pointer+1))
    fi
done

echo "result is $result"
