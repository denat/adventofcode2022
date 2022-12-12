monkeys={}

with open('input.txt') as f:
    lines = f.readlines()

# Build the monkeys
for line in lines:
    line = line.strip()
    if line.startswith('Monkey'):
        monkey = int(line.split(' ')[1][:-1])
        monkeys[monkey] = {}
    elif line.startswith('Starting items:'):
        monkeys[monkey]['items'] = line.split('Starting items: ')[1].split(', ')
    elif line.startswith('Operation:'):
        monkeys[monkey]['operation'] = line.split('Operation: new = ')[1]
    elif line.startswith('Test:'):
        monkeys[monkey]['test'] = int(line.split('Test: divisible by ')[1])
    elif line.startswith('If true:'):
        monkeys[monkey]['if_true_throw_to'] = int(line.split(' ')[-1])
    elif line.startswith('If false:'):
        monkeys[monkey]['if_false_throw_to'] = int(line.split(' ')[-1])

rounds=10000
monkey_inspects = dict.fromkeys(monkeys.keys(), 0)
lcm = 1
for key in monkeys:
    lcm = lcm * monkeys[key]['test']

for i in range(rounds):
    for key in monkeys:
        monkey = monkeys[key]

        if len(monkey['items']) == 0:
            continue

        while (len(monkey['items']) > 0):
            item = monkey['items'].pop(0)
            monkey_inspects[key] += 1
            new_worry_level = eval(monkey['operation'].replace('old', str(item)))
            newer_worry_level = new_worry_level % lcm
            
            if new_worry_level % monkey["test"] == 0:
                monkeys[monkey["if_true_throw_to"]]["items"].append(newer_worry_level)
            else:
                monkeys[monkey["if_false_throw_to"]]["items"].append(newer_worry_level)

for key in monkey_inspects:
    print('Monkey %s: %s' % (key, monkey_inspects[key]))

# Multiply the two highest monkey inspect counts together
print(monkey_inspects[max(monkey_inspects, key=monkey_inspects.get)] * monkey_inspects[sorted(monkey_inspects, key=monkey_inspects.get)[-2]])
    
