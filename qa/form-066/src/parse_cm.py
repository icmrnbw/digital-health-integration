import re,sys,json
out={}
for fn in sys.argv[1:]:
    cur=None;src=None
    for line in open(fn,encoding='utf-8'):
        m=re.match(r'Instance:\s*(\S+)',line)
        if m: cur=m.group(1); out[cur]={}; continue
        if cur is None: continue
        m=re.search(r'element\[[+=]?\]\.code = #(\S+)',line) or re.search(r'element\[\+\]\.code = #(\S+)',line)
        if m and '.target' not in line: src=m.group(1); out[cur].setdefault(src,[]); continue
        m=re.search(r'\.target\[[+=]\]\.code = #(\S+)',line)
        if m and src: out[cur][src].append(m.group(1)); continue
print(json.dumps(out,ensure_ascii=False,indent=1))
