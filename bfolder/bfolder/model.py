from mongoengine import connect
from mongoengine import StringField, Document, IntField

con = connect('bfolder')

class Image(Document):
    name = StringField()
    title = StringField()
    category = StringField()
    raiting = IntField()
    ctime = IntField()
    
class Comment(Document):
    body = StringField()
    time = IntField()
    to_image_name = StringField()
    
    
class CursorWrapper(object):

    """Wraps the MongoDB cursor to work with the paginate module."""

    def __init__(self, cur):
        self.cur = cur

    __iter__ = lambda self: self.cur.__iter__()
    __len__ = lambda self: self.cur.count()
    __getitem__ = lambda self, key: self.cur.__getitem__(key)
