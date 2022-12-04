#!/usr/bin/env bash

awk -v RS= '{$1=$1}1' input | sed 's/ /+/g' | bc | sort -n | tail -n 3 | tac | xargs -Ix echo "Top:" x
awk -v RS= '{$1=$1}1' input | sed 's/ /+/g' | bc | sort -n | tail -n 3 | awk -v RS= '{$1=$1}1' | sed 's/ /+/g' | bc | xargs -Ix echo "Total:" x