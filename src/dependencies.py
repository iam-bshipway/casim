import re
import os

files = [f for f in os.listdir('.') if f.endswith('.F90') or f.endswith('.f90')]
deps = {f: [] for f in files}

# rudimentary dependency scanner
for f in files:
    with open(f, 'r') as fp:
        for line in fp:
            m = re.match(r'^\s*use\s+([a-zA-Z0-9_]+)', line, re.IGNORECASE)
            if m:
                mod = m.group(1).lower()
                # look for the file that provides this module
                for f2 in files:
                    if f2 == f: continue
                    with open(f2, 'r') as fp2:
                        content = fp2.read()
                        if re.search(rf'^\s*module\s+{mod}\b', content, re.IGNORECASE | re.MULTILINE):
                            deps[f].append(f2)
                            break

ordered = []
visited = set()

def visit(f):
    if f in visited: return
    visited.add(f)
    for d in deps[f]:
        visit(d)
    ordered.append(f)

for f in files:
    visit(f)

print(" ".join(ordered))
