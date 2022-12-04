# Advent of Code 2022 - Bash

Hey there! This is my attempt at solving the [Advent of Code 2022](https://adventofcode.com/2022) puzzles in Bash.

OS used: OSX Monterey 12.6

## Handy commands

```sh
# Replace newlines with spaces
awk -v RS= '{$1=$1}1'

# Perform arithmetic (e.g. sum) on numbers separated by a space
sed 's/ /+/g' | bc
```

## Things I learned

- The ‘#‘ symbol can be used to count the length of the string without using any command, e.g. `line="test123"; echo ${#line}`
- Shell expansion:
  - $(command) - command substitution
  - $((expression)) - arithmetic expansion
  - ${variable} - variable substitution
  - <(command) - process substitution
- `${variable:start:length}` - Substring, where start is the index of the first character and length is the number of characters to extract. Use `${variable:start}` to extract from start to the end of the string.
- `comm` - compare two sorted files line by line and write to standard output: the lines that are common, plus the lines that are unique. IMPORTANT: The files must be sorted beforehand!
- `uniq` - remove duplicate lines
- `fold` - spread the content into multiple lines, with a specified width, e.g. `fold -w1` for one character per line.
- Always prepend files with `#!/usr/bin/env bash` instead of using zsh directly, because zsh doesn't support many of the features we need.
  For example, zsh doesn't work well with the `comm` command, gives us a syntax error.
- `<<<` is the syntax for [here strings](https://tldp.org/LDP/abs/html/x17837.html) -- it feeds the string to the left side's stdin

```sh
read first second <<< "hello world"
echo $second $first
```
