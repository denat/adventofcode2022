#!/usr/bin/env bash

awk -v RS= '{$1=$1}1' input | sed 's/ /+/g' | bc | sort -n | tail -n 1 | xargs -Ix echo "Most calories:" x