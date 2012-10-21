from mongoengine import connect
from mongoengine import StringField, Document, IntField, ListField
from pymongo import Connection

con = connect('bfolder')


class Image(Document):
    name = StringField()
    title = StringField()
    category = StringField()
    raiting = IntField()
    ctime = IntField()
    tags = ListField()
    lang = StringField()
    sid = IntField()


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


class Counter(object):
    """Set incremental integer indexes for Spinx indexer"""

    def __init__(self, db):
        self.con = Connection('localhost', 27017)
        self.db = self.con.bfolder

    def next_value(self, field):
        return self.db.counter.find_and_modify(query={"_id": field},
                                               update={"$inc": {"ind": 1}},
                                               upsert=True,
                                               new=True).get("ind")

    def modify(self, field, ind):
        return self.db.counter.find_and_modify(query={"_id": field, "ind":
                                                     {"$lt": int(ind)}},
                                               update={"$set":
                                                      {"ind": int(ind)}},
                                               upsert=True,
                                               new=True).get("ind")
