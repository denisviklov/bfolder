import helpers
from pyramid.i18n import get_localizer, TranslationStringFactory


def add_renderer_globals(event):
    event['h'] = helpers
    request = event['request']
    try:
        event['_'] = request.translate
    except AttributeError:
        pass
    event['localizer'] = request.localizer


def set_accepted_languages_locale(event):
    if not event.request.accept_language:
        return
    event.request._LOCALE_ = event.request.accept_language.best_match(('en', 'ru'), 'en')

tsf = TranslationStringFactory('bfolder')


def add_localizer(event):
    request = event.request
    localizer = get_localizer(request)

    def auto_translate(*args, **kwargs):
        return localizer.translate(tsf(*args, **kwargs))
    request.localizer = localizer
    request.translate = auto_translate
