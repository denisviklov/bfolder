"""Xml generator for sphinx handler"""

import sys
import elementflow

from bfolder.model import Image


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
                    xml.element('title', text=record.title)
                    xml.element('lang', text=record.lang)
                    xml.element('file', text=record.name)
                    xml.element('raiting', text='%d' %
                                int(record.raiting) if record.raiting else 0)
    return 0


xml_gen()