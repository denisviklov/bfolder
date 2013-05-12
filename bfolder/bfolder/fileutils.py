import cStringIO

from PIL import Image


class FileManager(object):
    IMG_MAX_SIZE = [(250, 250, 'small')]
    DEFAULT_EXTENSION = 'jpg'

    def __init__(self, file_obj, filename, formats):
        self.file_obj = file_obj
        self.filename = filename
        self.formats = formats or self.IMG_MAX_SIZE
        self.file_path = '/var/www/pack/'

    def _img_resize(self, format):
        max_size = format[:2]
        file_like = cStringIO.StringIO(self.file_obj)
        img = Image.open(file_like)
        max_x, max_y = max_size
        x, y = float(img.size[0]), float(img.size[1])
        r = min(max_x / x, max_y / y)
        img = img.resize([int(s * r) for s in img.size], Image.ANTIALIAS)
        img.save('%s%s_%s.jpg' % (self.file_path, format[2], self.filename))

    def _save_on_disk(self):
        file_like = cStringIO.StringIO(self.file_obj)
        img = Image.open(file_like)
        img.save('%s%s.jpg' % (self.file_path, self.filename))

    def process(self):
        self._save_on_disk()
        for format in self.formats:
            self._img_resize(format)