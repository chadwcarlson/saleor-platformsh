import os, sys, json

version_file='updates/project.json'
app = sys.argv[1]

with open(version_file, 'r') as f:
    data = json.load(f)
    upstreams = data['apps'][app]
    build_info = """
Build info ({0}):

    {1}: {2}
""".format(app, upstreams['runtime']['type'], upstreams['runtime']['version'])
for upstream in upstreams:
    if upstream != 'runtime':
        build_info += """    {0}: {1}
""".format(upstream, upstreams[upstream]['version'])
print(build_info)