# Advent of Code 2022 - Bash & Python

Hey there! This is my attempt at solving the [Advent of Code 2022](https://adventofcode.com/2022) puzzles in Bash and Python.

I retired Bash on day 11 part 2 because it was too slow 🐢, and switched to Python for the rest of the puzzles. 🐍

- OSX Monterey 12.6
- Bash 5.2.2(1)-release (x86_64-apple-darwin21.6.0)
- Python 3.8.2

## Handy bash commands

```sh
# Remove newlines
tr -d '\n'

# Replace newlines with spaces
awk -v RS= '{$1=$1}1'

# Perform arithmetic (e.g. sum) on numbers separated by a space
sed 's/ /+/g' | bc

# Parse nth word in a line
cut -d' ' -f2 # 2nd word
cut -d' ' -f3 # 3rd word

```

## Things I learned (Bash)

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

- Variables are global by default, even if they are declared inside a function. To make them local, use the `local` keyword.
- Bash has arrays, and you can implement stacks and queues. See day 5 for a Stack example.
- [IFS](https://bash.cyberciti.biz/guide/$IFS) (Internal Field Separator) is important! It determines how Bash recognizes Word boundaries. Useful when you care about parsing whitespace.
- Set multiple variables at once with `read`: `read -r var1 var2 <<< "hello world"`, or `read -r a b c < <(cut -d' ' -f2,4,6 <<< $line)`
- `==` is an alias for `=` and it performs a string (lexical) comparison, `eq` performs a numeric comparison.
- Array keys are accessed with `${!array[@]}` and values with `${array[@]}`. See day 7.
- Use `tac` to reverse a file, last line first.
- Bash supports multidimensional arrays:
  - Declare an array with `declare -A array_name`
  - Set an element with `array_name[key1,key2]=value`
  - Get all keys with `for key in "${!array_name[@]}"; do echo $key; done`
  - Get all values with `for value in "${array_name[@]}"; do echo $value; done`
  - Get length with `echo ${#array_name[@]}`
- Text interpolation only works with double quotes, not single quotes.
- In Bash, you can break out of multiple loops! By default, `break` only breaks out of the innermost loop. To break out of all loops, use `break 2` or `break 3` etc.
- You can use `BASH_REMATCH` to capture the matched string in a regex. If the latest [[]]-expression matched the string, the matched part of the string is stored in the BASH_REMATCH array.
- Remove the first part of a string with `string=${string#substring}`. Remove the last part with `string=${string%substring}`.
