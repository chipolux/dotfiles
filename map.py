#!python

########
# Usage:
#   tree -a -J | ./map.py | dot -Tpdf > map.pdf
########
import json
import sys


# output of tree -J will always have 2 entries, the top directory and a report
dirs = [json.loads(sys.stdin.read())[0]]
graph_template = """
graph {{
    graph [fontname="Cousine", overlap=scale, splines=true];
    node [fontname="Cousine", shape=folder];

    {nodes}
}}
"""
label_template = '<<font color="blue3">{d}</font><font color="darkorange3"><br align="left" />{f}</font>>'
file_template = '  {}<br align="left" />'

nodes = []
dirs[0]['p'] = -1
files = []
template = '    n{i} [label=' + label_template + '];'
while dirs:
    p = len(nodes)
    d = dirs.pop(0)
    for c in d['contents']:
        if c['type'] == 'directory':
            if c['name'] == '.git':
                # skip .git directory
                continue
            c['p'] = p
            dirs.append(c)
        if c['type'] == 'file':
            files.append(file_template.format(c['name']))

    nodes.append(template.format(i=p, d=d['name'], f=''.join(files), p=d['p']))
    files = []
    template = '    n{i} [label=' + label_template + ']; n{p} -- n{i};'

print(graph_template.format(nodes='\n'.join(nodes)))
