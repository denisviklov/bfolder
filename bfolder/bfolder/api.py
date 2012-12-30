#coding: utf-8

import time

from pyramid.httpexceptions import HTTPForbidden, HTTPOk, HTTPNotFound, HTTPBadRequest
from pyramid.security import authenticated_userid
from cornice import Service

from model import Image
from parser import Parser
from common import name_file, img_con

img_api = Service(name='image_api', path='/img/{image_hash}',
                  description="Admin api")
collection_api = Service(name='collection_api', path='/collection/',
                         description="Collection api")


@img_api.post()
def change_img_info(request):
    if authenticated_userid(request) == 'godmode':
        image_hash = request.matchdict.get('image_hash')
        img = Image.objects(name=image_hash).first()
        if not img:
            return HTTPNotFound()
        title = request.POST.get('title')
        lang = request.POST.get('lang')
        if title: img['title'] = title
        if lang: img['lang'] = lang
        img.save()
        return HTTPOk()
    return HTTPForbidden()


@img_api.delete()
def delete_img(request):
    if authenticated_userid(request) == 'godmode':
        image_hash = request.matchdict.get('image_hash')
        img = Image.objects(name=image_hash).first()
        if not img:
            return HTTPNotFound()
        img.delete()
        return HTTPOk()
    return HTTPForbidden()


@collection_api.post()
def get_thread_images(request):
    print 'start parsing ...', request.POST.get('thread_url')
    parser = Parser(request.POST.get('thread_url'))
    if request.POST.get('thread_url'):
        if request.POST.get('collection_name'):
            collection = Image(title=request.POST.get('collection_name'),
                               ctime=int(time.time()), lang='ru',
                               type='collection')
            collection = collection.save()
            #ugly flag but ...
            _iter = 0
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
            collection.save()
            print 'Parsing done'
            return HTTPOk()
        else:
            return HTTPBadRequest()