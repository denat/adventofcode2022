from functools import cmp_to_key
from itertools import zip_longest

with open('input.txt') as f:
    lines = f.readlines()
    lines = [line.strip() for line in lines if line.strip() != '']

def parse(line):
    result = []
    processed_chars = 0
    i = 1
    while i < len(line):
        processed_chars += 1
        char = line[i]
        if char == '[':
            parsed = parse(line[i:])
            result.append(parsed[0])
            i += parsed[1]
            processed_chars += parsed[1]
        elif char == ']':
            return [result, processed_chars]
        elif char == ',':
            pass
        else:
            num = ''
            j = i
            while line[j].isdigit():
                num += line[j]
                j += 1
            
            i += len(num)
            processed_chars += len(num) - 1
            result.append(int(num))
            continue
            
        i += 1

def compare(left, right):
    if left is None:
        return -1
    if right is None:
        return 1
    if isinstance(left, int) and isinstance(right, int):
        return -1 if left < right else 1 if left > right else 0
    else:
        l = [left] if isinstance(left, int) else left
        r = [right] if isinstance(right, int) else right
        for l1, r1 in zip_longest(l, r):
            result = compare(l1, r1)
            if result != 0:
                return result
        return 0

def part1():
    in_order_sum = 0
    curr_index = 1
    for i in range(0, len(lines), 2):
        left = lines[i]
        right = lines[i+1]
        if compare(parse(left)[0], parse(right)[0]) == -1:
            in_order_sum += curr_index
        curr_index += 1
    return in_order_sum

def part2():
    packets = [parse(line)[0] for line in lines]
    sorted_packets = sorted([*packets, [[2]], [[6]]], key=cmp_to_key(compare))
    return (sorted_packets.index([[2]])+1) * (sorted_packets.index([[6]])+1)

print("Part 1: " + str(part1()))
print("Part 2: " + str(part2()))



