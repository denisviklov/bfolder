"""Xml generator for sphinx handler"""

import sys
import elementflow

from bfolder.model import Image


def tolower(s):
    try:
        return s.lower()
    except AttributeError:
        return ''


def xml_gen():
    all_records = Image.objects()
    with elementflow.xml(sys.stdout, "sphinx:docset",
                         namespaces={"sphinx": "http://sphinxsearch.com/"},
                         indent=False) as xml:
        with xml.container("sphinx:schema"):
            xml.element("sphinx:field", attrs=dict(name="title", type="string"))
            xml.element("sphinx:attr", attrs=dict(name="lang", type="string"))
            xml.element("sphinx:attr", attrs=dict(name="file", type="string"))
            xml.element("sphinx:attr", attrs=dict(name="raiting", type="int"))

        for record in all_records:
            with xml.container("sphinx:document", attrs=dict(id="%d" %
                                                             record.sid)):
                xml.element('title', text=tolower(record.title))
                xml.element('lang', text=tolower(record.lang))
                xml.element('file', text=tolower(record.name))
                xml.element('raiting', text='%d' %
                            int(record.raiting) if record.raiting else 0)
    return 0


if __name__ == '__main__':
    sys.exit(xml_gen())