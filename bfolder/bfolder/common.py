import urllib
import random
import hashlib

from PIL import Image as Img

PACK_PATH = '/var/www/pack/'


def remove_tags(input_text):
    s_list = list(input_text)
    i = 0
    while i < len(s_list):
        if s_list[i] == '<':
            while s_list[i] != '>':
                s_list.pop(i)
            s_list.pop(i)
        else:
            i = i + 1
    join_char = ''
    return join_char.join(s_list)


def name_file():
    m = hashlib.md5()
    m.update(str(random.randrange(1000000000)))
    file_name = m.hexdigest()
    return file_name


def img_con(f_object, filename):
    #TODO: path must be move to config
    f = open('%s%s_full.%s' % (PACK_PATH, filename, 'jpg'), 'w')
    f.write(f_object.read())
    f.close()
    f_object.seek(0)
    img = Img.open(f_object)
    max_x, max_y = 200, 200
    x, y = float(img.size[0]), float(img.size[1])
    if x > max_x or y > max_y:
        r = min(max_x / x, max_y / y)
        img = img.resize([int(s * r) for s in img.size], Img.ANTIALIAS)
    img.save('%s%s.%s' % (PACK_PATH, filename, 'jpg'))
    return True


def get_image_from_remote(url):
    return urllib.urlretrieve(url)[0]


LANGS = {'en': 'en', 'ru': 'ru'}


def lang_neogitator(text):
    try:
        unicode(str(text))
        lang = LANGS['en']
    except Exception:
        lang = LANGS['ru']
    return lang


def back_url(request):
    back = '/'
    if request.referer is not None:
        if '?page' in request.referer:
            back = request.referer
        elif 'collections' in request.referer:
            back = request.referer
    return back
