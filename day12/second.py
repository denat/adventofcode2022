map = []
visited = []

with open('input.txt') as f:
    lines = f.readlines()
    map = [list(line.strip()) for line in lines]

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
    other_starting_positions = []

    while queue:
        curr = queue.pop(0)
        curr_x = curr[0]
        curr_y = curr[1]
        curr_dist = curr[2]

        if map[curr_x][curr_y] == 'E':
            return curr_dist

        if [curr_x, curr_y] in visited:
            continue

        if map[curr_x][curr_y] == 'S' or map[curr_x][curr_y] == 'a':
            other_starting_positions.append([curr_x, curr_y])

        visited.append([curr_x, curr_y])

        next_positions = get_next_positions(curr_x, curr_y)
        for next_pos in next_positions:
            if next_pos not in visited:
                queue.append([next_pos[0], next_pos[1], curr_dist + 1])

    # No path found, must be an island, remove all other starting positions in this path
    for other_starting_position in other_starting_positions:
        if other_starting_position in starting_positions:
            print("No path found, removing starting position: " + str(other_starting_position))
            starting_positions.remove(other_starting_position)

starting_positions = []
for i in range(len(map)):
    for j in range(len(map[i])):
        if map[i][j] == 'S' or map[i][j] == 'a':
            starting_positions.append([i, j])

print(str(len(starting_positions)))

amt = 0
found_at_least_one_distance = False
minimum_distance = 0
while starting_positions:
    amt += 1
    visited = []
    start_position = starting_positions.pop(0)
    dist = get_minimal_distance(start_position[0], start_position[1], 0)
    if not found_at_least_one_distance or (dist and dist < minimum_distance):
        minimum_distance = dist
        found_at_least_one_distance = True
    print(str(amt))
    print("Lowest so far: " + str(minimum_distance))

print(minimum_distance)
