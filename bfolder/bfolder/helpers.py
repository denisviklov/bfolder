from datetime import datetime
from model import Image


def time_pretify(string):
    dt = datetime.utcfromtimestamp(string)
    day = '0' + str(dt.day) if dt.day < 10 else str(dt.day)
    month = '0' + str(dt.month) if dt.month < 10 else str(dt.month)
    return '%s.%s.%d %d:%d' % (day, month, dt.year, dt.hour, dt.minute)


def get_tag_cloud():
    return Image.objects.filter(tags__ne=None, lang='en').item_frequencies('tags', normalize=True)