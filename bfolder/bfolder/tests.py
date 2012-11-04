import unittest
import logging

from pyramid import testing
import mock

from bfolder.views import (index, full_img, search_autocomplete,
                           search)


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

    @mock.patch('bfolder.views.search_autocomplete')
    def test_search_autocomplete(self, search_mocked):
        self.request.GET.update({'term': 'lol'})
        search_mocked(self.request)
        self.assert_(search_mocked.called)

    def test_search_not_q(self):
        self.request.POST.update({'q': None})
        result = search(self.request)
        self.assertIsNone(result)