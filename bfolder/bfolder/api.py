#coding: utf-8

import json
import time

from pyramid.httpexceptions import HTTPForbidden, HTTPOk, HTTPNotFound, HTTPBadRequest
from pyramid.security import authenticated_userid
from cornice import Service

from model import Image
from parser import Parser
from common import name_file, img_con

img_api = Service(name='image_api', path='/img/{image_hash}',
                  description="Admin api")
collection_api = Service(name='collection_api', path='/collection/{collection_id}',
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
    parser = Parser(request.POST.get('thread_url'))
    #import ipdb; ipdb.set_trace()
    if request.POST.get('thread_url'):
        if request.POST.get('collection_name'):
            collection = Image(name=request.POST.get('collection_name'),
                               raiting=0, ctime=int(time.time()), tags=[],
                               lang='ru', type='collection')
            collection = collection.save()
            #all goin OK ;)
            for img_file_obj in parser.parse_iter_images():
                filename = name_file()
                try:
                    img_con(img_file_obj, filename)
                    i = Image(name=filename, title='', category='', raiting=0,
                              ctime=int(time.time()), tags=[], lang='ru',
                              collection_id=collection.id)
                    i.save()
                except Exception:
                    pass
            return HTTPOk()
        else:
            return HTTPBadRequest()