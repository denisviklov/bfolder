USERS = {'godmode': 'godmode',
          'viewer': 'viewer'}
GROUPS = {'godmode': ['group: godmodes']}


def groupfinder(userid, request):
    if userid in USERS:
        return GROUPS.get(userid, [])