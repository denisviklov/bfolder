import urlparse

import helpers
from pyramid.i18n import get_localizer, TranslationStringFactory


def add_renderer_globals(event):
    event['h'] = helpers
    request = event['request']
    try:
        event['_'] = request.translate
        event['localizer'] = request.localizer
    except AttributeError:
        pass


def set_accepted_languages_locale(event):
    """.me - int, .org - russia"""
    locale_mapping = {'me': 'en', 'org': 'ru'}
    domain = urlparse.urlparse(event.request.host_url)
    try:
        zone = domain.hostname.split('.')[-1]
        event.request._LOCALE_ = locale_mapping.get(zone)
    except IndexError:
        event.request._LOCALE_ = 'ru'
    #event.request._LOCALE_ = \
            #event.request.accept_language.best_match(('en', 'ru'), 'ru')

tsf = TranslationStringFactory('bfolder')


def add_localizer(event):
    request = event.request
    localizer = get_localizer(request)

    def auto_translate(*args, **kwargs):
        return localizer.translate(tsf(*args, **kwargs))
    request.localizer = localizer
    request.translate = auto_translate
