import time

import celery
from mongoengine.base import ObjectId

from model import Image
from parser import Parser
from common import name_file, img_con

celery = celery.Celery('tasks', broker='amqp://pixchan:randomjunglist84@localhost:5672/vpixchan')


@celery.task(name='bfolder.tasks.get_thread_images')
def get_thread_images(message):
    print 'start parsing ...', message.get('thread_url')
    parser = Parser(message.get('thread_url'))
    #ugly flag but ...
    _iter = 0
    collection = Image.objects(id=ObjectId(message.get('collection_id'))).first()
    for img_file_obj in parser.parse_iter_images():
        filename = name_file()
        try:
            img_con(img_file_obj, filename)
            i = Image(name=filename, title='', category='', raiting=0,
                      ctime=int(time.time()), tags=[], lang='ru',
                      collection_id=collection.id)
            i.save()
            if not _iter:
                collection.name = filename
            _iter += 1
        except Exception, e:
            print e.message
    collection.length = _iter
    if _iter:
        collection.is_disabled = False
    collection.save()
    print 'Parsing done with ', _iter

