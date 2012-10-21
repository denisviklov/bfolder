"""This tool just set start incremented indexes for
sphinx indexer"""

from bfolder.model import Image, Counter, con


def create_indexes():
    all_records = Image.objects()
    for record in all_records:
        record.sid = Counter(con).next_value('doc')
        record.save()

if __name__ == '__main__':
    create_indexes()
