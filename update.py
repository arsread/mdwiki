import os
import json

jsonList = []
files = [f for f in os.listdir('.') if os.path.isfile(f)]
for f in files:
    if not f.endswith('.md'):
        continue
    if f == 'index.md' or f == 'navigation.md':
        continue
    line = open(f).readline()
    if line.startswith('#'):
        header = line[1:].strip()
        item = {}
        item['title'] = header
        item['id'] = str(f).replace('.md', '')
        jsonList.append(item)
with open('items.json', 'w') as outfile:
    json.dump(jsonList, outfile)
