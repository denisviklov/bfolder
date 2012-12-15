from pyramid.security import Everyone
from pyramid.security import Allow


class Root(object):
    def __init__(self, request):
        self.request = request


class SimpleAdmin(object):
    __acl__ = [
        (Allow, Everyone, 'view'),
        (Allow, 'group:editors', 'add'),
        (Allow, 'group:editors', 'edit'),
        ]
