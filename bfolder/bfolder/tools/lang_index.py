"""Simple tool for set lang option on all database"""

from bfolder.model import Image
from bfolder.common import lang_neogitator


def set_lang_to_all():
    all_records = Image.objects()
    for record in all_records:
        record.lang = lang_neogitator(record.title)
        record.save()


if __name__ == '__main__':
    set_lang_to_all()
