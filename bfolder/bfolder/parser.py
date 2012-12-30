import urllib
import urlparse

import lxml.html


class Crawler(object):

    @staticmethod
    def get_raw_html(url):
        return urllib.urlopen(url).read()

    @staticmethod
    def get_file_obj(url):
        img = open(urllib.urlretrieve(url)[0])
        return img


class Parser(object):

    def __init__(self, url):
        self.url = url
        self.html_doc = lxml.html.fromstring(Crawler.get_raw_html(self.url))

    #here parse images from 2-ch.so
    def parse_iter_images(self):
        thread_images = self.html_doc.xpath("//a[@name='expandfunc']")
        for img in thread_images:
            yield Crawler.get_file_obj('http://%s%s' % (urlparse.urlparse(self.url).netloc,
                                                 img.attrib.get('href')))
