#!/usr/bin/env bash

awk '{ print $1 $2 }' input | sed 's/AX/4/g;s/BX/1/g;s/CX/7/g;s/AY/8/g;s/BY/5/g;s/CY/2/g;s/AZ/3/g;s/BZ/9/g;s/CZ/6/g' | awk -v RS= '{$1=$1}1' | sed 's/ /+/g' | bc