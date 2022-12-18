with open("input.txt") as f:
    lines = [line.strip() for line in f.readlines()]

rocks = []
min_x, max_x, min_y, max_y = None, None, None, None
for line in lines:
    rock = []
    for point in line.split(" -> "):
        x, y = point.split(",")
        x, y = int(x), int(y)
        if min_x is None or x < min_x:
            min_x = x
        if max_x is None or x > max_x:
            max_x = x
        if min_y is None or y < min_y:
            min_y = y
        if max_y is None or y > max_y:
            max_y = y
        rock.append((x, y))
    rocks.append(rock)

map = [['.' for _ in range(0, max_x+1)] for _ in range(0, max_y+1)]

for rock in rocks:
    curr_point = rock[0]
    for next_point in rock[1:]:
        if curr_point[0] == next_point[0]:
            for y in range(min(curr_point[1], next_point[1]), max(curr_point[1], next_point[1])+1):
                map[y][curr_point[0]] = '#'
        else:
            for x in range(min(curr_point[0], next_point[0]), max(curr_point[0], next_point[0])+1):
                map[curr_point[1]][x] = '#'
        curr_point = next_point

for row in map:
    print("".join(row[min_x:]))

def get_sand_next_pos(map, x, y):
    next_y = y + 1
    if next_y >= len(map) or x < 0 or x >= len(map[next_y]):
        # off the map, but still return it
        return (x, y+1)
    if map[next_y][x] == '.':
        return (x, next_y)
    elif x-1 < 0 or map[next_y][x-1] == '.':
        return (x-1, next_y)
    elif x+1 >= len(map[next_y]) or map[next_y][x+1] == '.':
        return (x+1, next_y)
    else:
        return None

sand_starting_point = (500, 0)
curr_sand = None
while True:
    if curr_sand is None:
        curr_sand = [*sand_starting_point]
    next_pos = get_sand_next_pos(map, *curr_sand)
    if next_pos is None:
        map[curr_sand[1]][curr_sand[0]] = 'o'
        curr_sand = None
    elif next_pos[1] > max_y:
        break
    else:
        curr_sand = [*next_pos]

sand_in_rest = 0
for row in map:
    sand_in_rest += row.count('o')
    print("".join(row[min_x:]))

print("Sand in rest: " + str(sand_in_rest))

