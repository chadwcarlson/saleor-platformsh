import os, sys, json
from datetime import datetime

# python upstreams/bump.py upstream_lib new_version
upstream, new_version = sys.argv[1:3]

version_file = 'upstreams/versions.json'

# Scheduled update defaults (what's the fleet context here?):
#   patch updates: update performed, auto-merge triggered into staging.
#   minor updates: update performed, activity script triggered for review.
#   major updates: no update performed.
# Assumes:
#   production
#       staging
#           auto-updates
#           dev1
#           devN

# Send a Slack message (Activity Script if there is a non-patch upgrade)
# Regularly resync production data
# Auto-merge passing patch releases?
# Auto updates on P.sh container versions? (augustin's community script?)
update_defaults = {
    "allowed": {
        "major": False,
        "minor": True,
        "patch": True
    }
}

def is_patch(old, new):
    if len(old) >= 3 and len(new) >= 3:
        return old.split('.')[2] != new.split('.')[2]
def is_minor(old, new):
    if len(old) >= 2 and len(new) >= 2:
        return old.split('.')[1] != new.split('.')[1]
def is_major(old, new):
    if len(old) >= 1 and len(new) >= 1:
        return old.split('.')[0] != new.split('.')[0]

def write_updates(data, new_version, release_type):
    data[upstream]['previous']['version'] = data[upstream]['version']

    now = datetime.now()
    data[upstream]['previous']['release'] = release_type
    data[upstream]['version'] = new_version
    data[upstream]['last_update'] = now.strftime("%m-%d-%Y-%H:%M")
    with open(version_file, 'w') as json_file:
        json.dump(data, json_file, indent=4, sort_keys=True)


with open(version_file, 'r') as f:
    data = json.load(f)
    update_rules = data["allowed"] or update_defaults["allowed"]
    if is_major(data[upstream]['version'], new_version) and update_rules['major']:
        write_updates(data, new_version, "major")
    elif is_minor(data[upstream]['version'], new_version) and update_rules['minor']:
        write_updates(data, new_version, "minor")
    elif is_patch(data[upstream]['version'], new_version) and update_rules['patch']:
        write_updates(data, new_version, "patch")
