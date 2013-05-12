#coding: utf-8

import time
import json
import base64

from pyramid.response import Response
from pyramid.httpexceptions import HTTPForbidden, HTTPOk, HTTPNotFound, HTTPBadRequest
from pyramid.security import authenticated_userid
from cornice import Service

from model import Image
from fileutils import FileManager

import bfolder.tasks

img_api = Service(name='image_api', path='/img/{image_hash}',
                  description="Admin api")


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


collection_api = Service(name='collection_api', path='/collection/',
                         description="Iamges collections api")


@collection_api.post()
def get_thread_images(request):
    if request.POST.get('thread_url'):
        if request.POST.get('collection_name'):
            message = {'thread_url': request.POST.get('thread_url'),
                       'collection_name': request.POST.get('collection_name')}
            collection = Image(title=message.get('collection_name'),
                               ctime=int(time.time()), lang='ru',
                               type='collection', is_disabled=True)
            collection = collection.save()
            message['collection_id'] = collection.id.__str__()
            bfolder.tasks.get_thread_images.delay(message)
            return Response(json.dumps({'collection_id': message['collection_id']}))
        else:
            return HTTPBadRequest()


open_api = Service(name='open_api', path='/api/image/{given_id}',
                         description="Image api")


@open_api.post()
def recive_images(request):
    img = request.POST.get('file')
    img = base64.decodestring(img[img.find('base64') + 7:])
    file_manager = FileManager(img, request.POST.get('filename'), []).process()
    return HTTPOk()