import json

from pyramid.httpexceptions import HTTPForbidden, HTTPAccepted, HTTPNotFound
from pyramid.security import authenticated_userid
from cornice import Service

from model import Image

img_api = Service(name='image_api', path='/img/{image_hash}', description="Admin api")


@img_api.post()
def change_img_info(request):
    if authenticated_userid(request) == 'godmode':
        image_hash = request.matchdict('image_hash')
        img = Image.objects(name=image_hash).first()
        if not img:
            return HTTPNotFound()
        title = request.matchdict('title')
        lang = request.matchdict('lang')
        if title: img['title'] = title
        if lang: img['lang'] = lang
        img.save()
        return HTTPAccepted()
    return HTTPForbidden()


@img_api.delete()
def delete_img(request):
    if authenticated_userid(request) == 'godmode':
        image_hash = request.matchdict.get('image_hash')
        img = Image.objects(name=image_hash).first()
        if not img:
            return HTTPNotFound()
        img.delete()
        return HTTPAccepted()
    return HTTPForbidden()


