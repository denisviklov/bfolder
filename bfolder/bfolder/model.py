from mongoengine import connect
from mongoengine import StringField, Document

con = connect('bfolder')

class Image(Document):

    name = StringField()
    title = StringField()
    category = StringField()
    
    
class CursorWrapper(object):

    """Wraps the MongoDB cursor to work with the paginate module."""

    def __init__(self, cur):
        self.cur = cur

    __iter__ = lambda self: self.cur.__iter__()
    __len__ = lambda self: self.cur.count()
    __getitem__ = lambda self, key: self.cur.__getitem__(key)
