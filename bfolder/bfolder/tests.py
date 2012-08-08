import unittest
import logging

from pyramid import testing

from bfolder.views import index, full_img, search_autocomplete


log = logging.getLogger(__name__)


class ViewTests(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        self.request = testing.DummyRequest(_LOCALE_='en')
        super(ViewTests, self).__init__(*args, **kwargs)

    def setUp(self):
        self.config = testing.setUp()

    def tearDown(self):
        testing.tearDown()

    def test_index_GET(self):
        info = index(self.request)
        self.assertIn('pager', info)

    def test_index_POST(self):
        self.request.POST.update({'q': 'lol'})
        info = index(self.request)
        self.request.POST.clear()
        self.assertIn('pager', info)

    def test_full_img_NotFound(self):
        self.request.matchdict.update({'img_id': None})
        info = full_img(self.request)
        self.assertIsInstance(info, Exception)

    def test_seqarch_autocomplete(self):
        self.request.GET.update({'term': 'lol'})
        info = search_autocomplete(self.request)
        self.assert_(info)
