import helpers
from pyramid.i18n import get_localizer, TranslationStringFactory

def add_renderer_globals(event):
    event['h'] = helpers
    request = event['request']
    event['_'] = request.translate
    event['localizer'] = request.localizer
    
tsf = TranslationStringFactory('bfolder')

def add_localizer(event):
    request = event.request
    localizer = get_localizer(request)
    def auto_translate(string):
        return localizer.translate(tsf(string))
    request.localizer = localizer
    request.translate = auto_translate