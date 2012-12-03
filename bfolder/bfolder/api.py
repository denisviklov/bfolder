import json

from pyramid.httpexceptions import HTTPForbidden, HTTPOk, HTTPNotFound
from pyramid.security import authenticated_userid
from cornice import Service

from model import Image

img_api = Service(name='image_api', path='/img/{image_hash}', description="Admin api")


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


