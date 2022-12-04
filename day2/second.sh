#!/usr/bin/env bash

awk '{ print $1 $2 }' input | sed 's/AX/3/g;s/BX/1/g;s/CX/2/g;s/AY/4/g;s/BY/5/g;s/CY/6/g;s/AZ/8/g;s/BZ/9/g;s/CZ/7/g' | awk -v RS= '{$1=$1}1' | sed 's/ /+/g' | bc