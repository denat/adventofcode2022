map = []
visited = []

with open('input.txt') as f:
    lines = f.readlines()
    map = [list(line.strip()) for line in lines]

def find_start_position(map):
    for i in range(len(map)):
        for j in range(len(map[i])):
            if map[i][j] == 'S':
                return [i, j]

start_position = find_start_position(map)

def get_char_elevation(char):
    if char == 'S':
        return 96
    if char == 'E':
        return 122
    return ord(char)

def get_next_positions(x, y):
    positions = []
    curr_height = map[x][y]
    curr_ord = get_char_elevation(curr_height)
    
    if x > 0 and (get_char_elevation(map[x - 1][y]) <= curr_ord or curr_ord + 1 == get_char_elevation(map[x - 1][y])):
        positions.append([x - 1, y])
    if x < len(map) - 1 and (get_char_elevation(map[x + 1][y]) <= curr_ord or curr_ord + 1 == get_char_elevation(map[x + 1][y])):
        positions.append([x + 1, y])
    if y > 0 and (get_char_elevation(map[x][y - 1]) <= curr_ord or curr_ord + 1 == get_char_elevation(map[x][y - 1])):
        positions.append([x, y - 1])
    if y < len(map[x]) - 1 and (get_char_elevation(map[x][y + 1]) <= curr_ord or curr_ord + 1 == get_char_elevation(map[x][y + 1])):
        positions.append([x, y + 1])
    return positions

def get_minimal_distance(x, y, dist):
    queue = []

    queue.append([x, y, dist])

    while queue:
        curr = queue.pop(0)
        curr_x = curr[0]
        curr_y = curr[1]
        curr_dist = curr[2]

        if map[curr_x][curr_y] == 'E':
            return curr_dist

        if [curr_x, curr_y] in visited:
            continue

        visited.append([curr_x, curr_y])

        next_positions = get_next_positions(curr_x, curr_y)
        for next_pos in next_positions:
            if next_pos not in visited:
                queue.append([next_pos[0], next_pos[1], curr_dist + 1])

dist = get_minimal_distance(start_position[0], start_position[1], 0)
print(dist)
