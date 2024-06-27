import re
import sys

whitelist = 'D'
if len(sys.argv) > 1:
    whitelist = sys.argv[1]

with open('callsigns.txt', 'r') as file:
    callsigns = [line.rstrip('\n') for line in file.readlines()]

# parse callsigns into prefix, number and suffix
tokens = []
for callsign in callsigns:
    match = re.fullmatch('([A-Z]{2,2})([0-9])([A-Z]{1,7})', callsign)
    if not match:
        continue
    if not re.fullmatch(whitelist, callsign):
        continue
    tokens.append(match.groups())

# build list of prefixes and index over suffixes
prefixes = []
by_suffix = {}
for t in tokens:
    prefix = t[0]
    suffix = t[2]

    if suffix not in by_suffix:
        by_suffix[suffix] = []

    prefixes.append(prefix)
    by_suffix[suffix].append('%s%s' % (t[0], t[1]))
prefixes = set(prefixes)

prefixes = sorted(list(prefixes))
suffixes = sorted(list(by_suffix.keys()), key=lambda x: (len(x), x))

# header
print('| %-7s' % 'suffix', end='')
for prefix in prefixes:
    print(' | %-10s' % prefix, end='')
print(' |')

print('| %7s' % ('-' * 7), end='')
for prefix in prefixes:
    print(' | %10s' % ('-' * 10), end='')
print(' |')

# data
for suffix in suffixes:
    print('| %-7s' % suffix, end='')
    for prefix in prefixes:
        print(' | ', end='')
        for i in range(0, 9 + 1):
            if '%s%d' % (prefix, i) in by_suffix[suffix]:
                print('%d' % i, end='')
            else:
                print(' ', end='') # free
    print(' |')
